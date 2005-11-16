Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030435AbVKPS6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030435AbVKPS6m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 13:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030438AbVKPS6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 13:58:42 -0500
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:22472
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S1030435AbVKPS6l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 13:58:41 -0500
From: "Alejandro Bonilla" <abonilla@linuxwireless.org>
To: Pavel Machek <pavel@suse.cz>, Hui Cheng <hcheng@cse.unl.edu>
Cc: kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
Subject: Re: How to quickly detect the mode change of a hard disk?
Date: Wed, 16 Nov 2005 12:58:27 -0600
Message-Id: <20051116185628.M35560@linuxwireless.org>
In-Reply-To: <20051113151056.GB2193@spitz.ucw.cz>
References: <200511102334.10926.cloud.of.andor@gmail.com> <Pine.GSO.4.44.0511121122430.15078-100000@cse.unl.edu> <20051113151056.GB2193@spitz.ucw.cz>
X-Mailer: Open WebMail 2.40 20040816
X-OriginatingIP: 16.90.17.175 (abonilla@linuxwireless.org)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Nov 2005 15:10:56 +0000, Pavel Machek wrote
> > I am currently doing a kernel module involves detecting/changing
> > disk mode among STANDBY and ACTIVE/IDLE. I used ide_cmd_wait() to issue
> > commands like WIN_IDLEIMMEDIATELY and WIN_STANDBYNOW1. The problem is, a
> > drive in standby mode will automatically awake whenever a disk operation
> > is requested and I need to know the mode change as soon as possible. (So I
> 
> AFAIK there's no nice way to get that info, but it is useful, so 
> patch would be welcome.

I would check the hdparm man page again. Still, it sounds interesting.

Additionally, it could be cool if someone could finish up or make the option
for the HD freeze to use it with the HDAPS driver. ;-)

.Alejandro
