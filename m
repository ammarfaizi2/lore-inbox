Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932080AbWIAOgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbWIAOgZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 10:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbWIAOgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 10:36:25 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:11181 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932080AbWIAOgY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 10:36:24 -0400
Date: Fri, 1 Sep 2006 16:33:45 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Alan Stern <stern@rowland.harvard.edu>
cc: Jan-Hendrik Zab <xaero@gmx.de>, linux-kernel@vger.kernel.org,
       greg@kroah.com, linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Problem with USB storage devices, error -110
In-Reply-To: <Pine.LNX.4.44L0.0609011006190.6444-100000@iolanthe.rowland.org>
Message-ID: <Pine.LNX.4.61.0609011633080.27492@yvahk01.tjqt.qr>
References: <Pine.LNX.4.44L0.0609011006190.6444-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Subject: Re: [linux-usb-devel] Problem with USB storage devices, error -110
>
>It seems pretty clear that the UHCI controller hardware on your PCI card
>isn't working.  The "len=-8/64" messages are a dead giveaway; you can't
>get a negative length with a timeout failure if the controller is working
>right.  At least, not unless you have some other USB devices already
>attached to the same controller and using up all the bandwidth.
>
>The fact that it fails in the same way with all the USB devices you attach 
>is another indicator that the controller is bad.

BTW, error 110 is ETIMEDOUT. I have had that on one buggy USB mp3 player 
too - so it's not always the USB host controller.


Jan Engelhardt
-- 
