Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268490AbUJMGdT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268490AbUJMGdT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 02:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268496AbUJMGdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 02:33:19 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36235 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268490AbUJMGdP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 02:33:15 -0400
Message-ID: <416CCC1A.5020301@pobox.com>
Date: Wed, 13 Oct 2004 02:32:58 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Danny <dannydaemonic@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: mm kernel oops with r8169 & named, PREEMPT
References: <9625752b041012230068619e68@mail.gmail.com>
In-Reply-To: <9625752b041012230068619e68@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Danny wrote:
> This is with the network driver r8169 and linux-2.6.9-rc4-mm1.  Same
> thing happened with linux-2.6.9-rc3-mm3 (but also locked up). 
> linux-2.6.8.1-mm4 didn't seem to have this problem.  This is very
> repeatable, if this is an unknown issue let me know (CC please, not on
> the list) and I will jump through the hoops to get a useful oops.

What happens if you disable preempt?

lspci?  config?  Any of the other useful info mentioned in the 
REPORTING-BUGS file in the kernel tree?

	Jeff



