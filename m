Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263073AbUKTQbO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263073AbUKTQbO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 11:31:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263106AbUKTQbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 11:31:13 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:44453 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S263073AbUKTQbE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 11:31:04 -0500
Date: Sat, 20 Nov 2004 17:30:54 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Is controlling DVD speeds via SET_STREAMING supported?
In-Reply-To: <20041120161704.GA14743@hardeman.nu>
Message-ID: <Pine.LNX.4.53.0411201727000.925@yvahk01.tjqt.qr>
References: <20041120161704.GA14743@hardeman.nu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi,
>
>currently my DVD player sounds like a jet plane when playing ordinary
>audio CD's. I tried the different approaches to lowering playback speed
>that are commonly used (hdparm, setspeed, etc) but none of them worked.

I doubt hdparm works on CD/DVD drives.
What is setspeed doing, internally?

My CD drives spin at "normal" (no more than speed 8) when playing CD-DA,
if I am listening to Ogg, I manually spin it down by using "calm-cdrom".
( http://linux01.org:2222/f/UHXT/sbin/src/calm-cdrom.c )

>Then I found this thread:
>http://marc.theaimsgroup.com/?t=99366299900003&r=1&w=2

BTW, I can't spindown CD-DA, because upon opening /dev/hdb for the ioctl, the
cd player resets :)



Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
