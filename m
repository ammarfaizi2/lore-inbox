Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161149AbVKSCGh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161149AbVKSCGh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 21:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161154AbVKSCGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 21:06:37 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:1165 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1161149AbVKSCGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 21:06:36 -0500
Subject: Re: [2.6 patch] i386: always use 4k stacks
From: Lee Revell <rlrevell@joe-job.com>
To: Rob Landley <rob@landley.net>
Cc: Adrian Bunk <bunk@stusta.de>, Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200511181933.27320.rob@landley.net>
References: <1132020468.27215.25.camel@mindpipe>
	 <dld3cs$1sh$1@sea.gmane.org> <20051115185543.GI5735@stusta.de>
	 <200511181933.27320.rob@landley.net>
Content-Type: text/plain
Date: Fri, 18 Nov 2005 21:02:59 -0500
Message-Id: <1132365780.6874.53.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-11-18 at 19:33 -0600, Rob Landley wrote:
> On Tuesday 15 November 2005 12:55, Adrian Bunk wrote:
> > I experienced something similar with my patch to schedule OSS drivers
> > with ALSA replacements for removal - when someone reported he needed an
> > OSS driver for $reason I asked him for bug numbers in the ALSA bug
> > tracking system - and the highest number were 4 new bugs against one
> > ALSA driver.
> 
> Speaking of which: I've been playing with qemu recently, and the sound card it 
> emulates is a sound blaster 16.  Which only seems to have an OSS driver, no 
> ALSA...
> 
> This is known?  If so I might take a whack at porting this if I get really 
> bored this weekend...

There already is an ALSA driver, check out sound/isa/sb/sb16.c:

/*
 *  Driver for SoundBlaster 16/AWE32/AWE64 soundcards
 *  Copyright (c) by Jaroslav Kysela <perex@suse.cz>

etc

Lee

