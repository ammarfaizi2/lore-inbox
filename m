Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267605AbUG3FIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267605AbUG3FIW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 01:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267317AbUG3FIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 01:08:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:37799 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267605AbUG3FIN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 01:08:13 -0400
Date: Fri, 30 Jul 2004 01:08:10 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@dhcp83-76.boston.redhat.com
To: MA <admin@sms13.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel problems, crc32c
In-Reply-To: <1623453663.20040730040321@sms13.de>
Message-ID: <Xine.LNX.4.44.0407300104350.18414-100000@dhcp83-76.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jul 2004, MA wrote:

> Test 7: 
> 6f630fad67cda0ee1fb1f562db63aa53e 
> Pass 
> 
> 
> AT THIS POINT IT HANGS

Was this during boot?  Do you have tcrypt built in or are you loading it 
manually?

> This is redhat enterprise 3.0, I was trying a couple 2.6.X serie
> kernels and the error was the same each time, I was also trying to
> exlcude crc32 options from kernel but it didnt help, I was not able to
> find the resolution on google, so here I am asking for help, thanks

Which kernel version exactly, and what is your .config?

Did you have the NMI watchdog enabled?  (If not, please do so).


- James
-- 
James Morris
<jmorris@redhat.com>



