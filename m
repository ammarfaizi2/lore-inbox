Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263113AbUKTQpr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263113AbUKTQpr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 11:45:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263117AbUKTQpr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 11:45:47 -0500
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:15375 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id S263113AbUKTQpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 11:45:43 -0500
Date: Sat, 20 Nov 2004 17:45:40 +0100
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Is controlling DVD speeds via SET_STREAMING supported?
Message-ID: <20041120164537.GB14743@hardeman.nu>
References: <20041120161704.GA14743@hardeman.nu> <Pine.LNX.4.53.0411201727000.925@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0411201727000.925@yvahk01.tjqt.qr>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 20, 2004 at 05:30:54PM +0100, Jan Engelhardt wrote:
>I doubt hdparm works on CD/DVD drives.
>What is setspeed doing, internally?

Well, hdparm does work for CD drives (hdparm -E), but not for CD/DVD 
combo drives...

And also, the tools I was thinking of isn't called setspeed...it's called 
setcd, and it uses ioctl(fd, CDROM_SELECT_SPEED, speed) which doesn't 
work on DVD players apparently. The same goes for the other tools I've 
tested ("hdparm -E" and "eject -x").

>
>My CD drives spin at "normal" (no more than speed 8) when playing CD-DA,
>if I am listening to Ogg, I manually spin it down by using "calm-cdrom".
>( http://linux01.org:2222/f/UHXT/sbin/src/calm-cdrom.c )

Which also uses the above mentioned ioctl...

Re,
David

