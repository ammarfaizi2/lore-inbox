Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932107AbWKLMfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbWKLMfe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 07:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755093AbWKLMfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 07:35:34 -0500
Received: from emailer.gwdg.de ([134.76.10.24]:27330 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1755090AbWKLMfd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 07:35:33 -0500
Date: Sun, 12 Nov 2006 13:34:27 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
cc: Andrey Borzenkov <arvidjaar@mail.ru>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc5: grub is much slower resuming from suspend-to-disk
 than in 2.6.18
In-Reply-To: <200611121326.12309.rjw@sisk.pl>
Message-ID: <Pine.LNX.4.61.0611121333530.2004@yvahk01.tjqt.qr>
References: <200611121436.46436.arvidjaar@mail.ru> <200611121326.12309.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> This is rather funny; in 2.6.19-rc5 grub is *really* slow loading kernel when
>> I switch on the system after suspend to disk. Actually, after kernel has been
>> loaded, the whole resuming (up to the point I have usable desktop again)
>> takes about three time less than the process of loading kernel + initrd.
>> During loading disk LED is constantly lit. This almost looks like kernel
>> leaves HDD in some strange state, although I always assumed HDD/IDE is
>> completely reinitialized in this case.

Constant LED, it might be the regular DMA culprit. Just a guess, 
however.


	-`J'
-- 
