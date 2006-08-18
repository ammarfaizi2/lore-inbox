Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751307AbWHRJAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbWHRJAG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 05:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbWHRJAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 05:00:06 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:40346 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751307AbWHRJAE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 05:00:04 -0400
Date: Fri, 18 Aug 2006 10:52:56 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Seewer Philippe <philippe.seewer@bfh.ch>
cc: Jeff Garzik <jeff@garzik.org>, Gabor Gombas <gombasg@sztaki.hu>,
       Adrian Bunk <bunk@stusta.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: /dev/sd*
In-Reply-To: <44E56804.1080906@bfh.ch>
Message-ID: <Pine.LNX.4.61.0608181050490.27740@yvahk01.tjqt.qr>
References: <1155144599.5729.226.camel@localhost.localdomain>
 <20060809212124.GC3691@stusta.de> <1155160903.5729.263.camel@localhost.localdomain>
 <20060809221857.GG3691@stusta.de> <20060810123643.GC25187@boogie.lpds.sztaki.hu>
 <44DB289A.4060503@garzik.org> <44E3DFD6.4010504@PicturesInMotion.net>
 <Pine.LNX.4.61.0608171000220.19847@yvahk01.tjqt.qr> <44E42900.1030905@PicturesInMotion.net>
 <Pine.LNX.4.61.0608171120260.4252@yvahk01.tjqt.qr> <44E56804.1080906@bfh.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Less advanced users should use the upgrade tools their distribution 
>> provides.
>
>And personally I think less advanced users will be very happy with
>/dev/disk (or /dev/hd). No more confusion wether to user /dev/hdx or
>/dev/sdx or whatever!

Umm, hdx or sdx is a small impact. The real power of /dev/disk is that 
not-so-technically minded users can go looking for their disk by its name 
(or less frequently, by their address (e.g. USB drive)). Especially 
important since any new disk discovered in the scsi layer gets the next 
free slot.


Jan Engelhardt
-- 
