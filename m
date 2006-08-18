Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932479AbWHRP5e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479AbWHRP5e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 11:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932474AbWHRP5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 11:57:34 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:14306 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932336AbWHRP5d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 11:57:33 -0400
Date: Fri, 18 Aug 2006 17:51:53 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Seewer Philippe <philippe.seewer@bfh.ch>, Jeff Garzik <jeff@garzik.org>,
       Gabor Gombas <gombasg@sztaki.hu>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: /dev/sd*
In-Reply-To: <1155913072.28764.3.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0608181748280.11320@yvahk01.tjqt.qr>
References: <1155144599.5729.226.camel@localhost.localdomain> 
 <20060809212124.GC3691@stusta.de>  <1155160903.5729.263.camel@localhost.localdomain>
  <20060809221857.GG3691@stusta.de>  <20060810123643.GC25187@boogie.lpds.sztaki.hu>
  <44DB289A.4060503@garzik.org> <44E3DFD6.4010504@PicturesInMotion.net> 
 <Pine.LNX.4.61.0608171000220.19847@yvahk01.tjqt.qr>  <44E42900.1030905@PicturesInMotion.net>
  <Pine.LNX.4.61.0608171120260.4252@yvahk01.tjqt.qr>  <44E56804.1080906@bfh.ch>
  <Pine.LNX.4.61.0608181050490.27740@yvahk01.tjqt.qr>
 <1155913072.28764.3.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Umm, hdx or sdx is a small impact. The real power of /dev/disk is that 
>> not-so-technically minded users can go looking for their disk by its name 
>
>They already can. It appears on their desktop with a little picture that
>says "My iSpod" or similar 8)

Not everyone follows Linus's "suggestion" to use KDE. Actually, there are 
even people not thrilled by either KDE or GNOME.

>What sort of "name" are you considering for /dev/disk ?

Whatever udev does currently seems good:

17:48 shanghai:~ > ls /dev/disk/by-id/*
/dev/disk/by-id/ata-DIAMOND_250G_2B5400_030400026
/dev/disk/by-id/ata-DIAMOND_250G_2B5400_030400026-part1
/dev/disk/by-id/usb-0_USB_DRIVE_0000000000004287
/dev/disk/by-id/usb-0_USB_DRIVE_0000000000004287-part1



Jan Engelhardt
-- 
