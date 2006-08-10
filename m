Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161073AbWHJGVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161073AbWHJGVV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 02:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161072AbWHJGVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 02:21:21 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:460 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1161067AbWHJGVU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 02:21:20 -0400
Date: Thu, 10 Aug 2006 08:19:08 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: /dev/sd*
In-Reply-To: <1155174291.18272.1.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0608100815450.10926@yvahk01.tjqt.qr>
References: <1155144599.5729.226.camel@localhost.localdomain> 
 <20060809212124.GC3691@stusta.de>  <1155160903.5729.263.camel@localhost.localdomain>
  <20060809221857.GG3691@stusta.de> <1155174291.18272.1.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> And things become even more confusing considering that the drive might 
>> show up as /dev/sda or /dev/uba depending on the driver used.
>
>Windows people seem to cope ok with C: being IDE and E: being SCSI ;)

You can't compare it like that. Actually, drive letters are more like
bind mounts from "device names" to drive letters. In fact, net drives
are not IDE or SCSI or USB at all, yet they have a drive letter. So the
real CDROM for example is, IIRC, sth. like \\Device\Cdrom0 (it's not a
network path even if it looks like).


Jan Engelhardt
-- 
