Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310504AbSCUX5j>; Thu, 21 Mar 2002 18:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310517AbSCUX53>; Thu, 21 Mar 2002 18:57:29 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:8376 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S310515AbSCUX52>; Thu, 21 Mar 2002 18:57:28 -0500
To: HGadi@ecutel.com (Hari Gadi)
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: module (kernel) debugging
In-Reply-To: <E16oBVq-0006Z6-00@the-village.bc.nu>
From: Olaf Dietsche <olaf.dietsche--list.linux-kernel@exmail.de>
Date: Fri, 22 Mar 2002 00:46:07 +0100
Message-ID: <87663pmqm8.fsf@tigram.bogus.local>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) XEmacs/21.4 (Artificial
 Intelligence, i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

>> I am new to kernel level development. What are the best ways to debug runtime
>> kernel (module).
>
> Your brain 8)

I can confirm this :-).

>> Are there any third party tools for debugging the kernel.

A _first_ party tool, which comes to my mind is:
	printk(KERN_DEBUG "whatever\n");
The advantage with printk() is, others can test and debug your module
as well and report results to you.

Regards, Olaf.
