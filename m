Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162958AbWLBL2G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162958AbWLBL2G (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 06:28:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162963AbWLBL2G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 06:28:06 -0500
Received: from mailer-b2.gwdg.de ([134.76.10.29]:41119 "EHLO mailer-b2.gwdg.de")
	by vger.kernel.org with ESMTP id S1162958AbWLBL2D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 06:28:03 -0500
Date: Sat, 2 Dec 2006 12:11:14 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Arjan van de Ven <arjan@infradead.org>
cc: Ben Collins <ben.collins@ubuntu.com>, linux-kernel@vger.kernel.org,
       Eric Piel <eric.piel@tremplin-utc>
Subject: Re: [RFC] Include ACPI DSDT from INITRD patch into mainline
In-Reply-To: <1165055432.3233.151.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.61.0612021210100.1635@yvahk01.tjqt.qr>
References: <1164998179.5257.953.camel@gullible> <1165055432.3233.151.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> I'd be willing to bet that most distros have this patch in their kernel.
>> One of those things we can't really live without.
>> 
>> What I haven't understood is why it isn't included in the mainline
>> kernel yet.
>
>it's not that hard ;)
>
>replacing the DSDT code *while it's live* is just a bad idea. The kernel
>already has a facility to override the DSDT, but that one does it *from
>the start*. Sounds like that one should be used or maybe enhanced a
>little to make it more distro friendly if something is lacking.

Speaking of that, would not it be "cleanest" to load the DSDT between 
grub/lilo and the kernel? GRUB can do fs harvesting (lookup) so you 
would not even need to recreate an initrd.


	-`J'
-- 
