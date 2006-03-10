Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751047AbWCJHUl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbWCJHUl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 02:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752066AbWCJHUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 02:20:41 -0500
Received: from wb1-a.mail.utexas.edu ([128.83.126.134]:15378 "EHLO
	wb1-a.mail.utexas.edu") by vger.kernel.org with ESMTP
	id S1751047AbWCJHUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 02:20:41 -0500
Message-ID: <441128C4.9020202@mail.utexas.edu>
Date: Thu, 09 Mar 2006 23:20:36 -0800
From: Philip Langdale <philipl@mail.utexas.edu>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: bjdouma@xs4all.nl, linux-kernel@vger.kernel.org
Subject: Re: pci-pci-quirk-for-asus-a8v-and-a8v-deluxe-motherboards.patch
References: <4410F1B7.80302@mail.utexas.edu> <20060310063836.GA31213@suse.de>
In-Reply-To: <20060310063836.GA31213@suse.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
>>
>> I'm not sure what the most efficient way to generalise it - especially
>> with cases like the Soyo one where there's no proper subvendor id.
> 
> Great, thanks for the information.  How about just adding new device ids
> for the new machines that also need this function called.  It's quite
> easy to do that...

Actually, I would go as far as to say just drop the check for the
subsystem vendor completely and unconditionally read the pci config
byte.

--phil
