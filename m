Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263372AbTDCMeN>; Thu, 3 Apr 2003 07:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263375AbTDCMeN>; Thu, 3 Apr 2003 07:34:13 -0500
Received: from cc78409-a.hnglo1.ov.home.nl ([212.120.97.185]:52930 "EHLO
	dexter.hensema.net") by vger.kernel.org with ESMTP
	id <S263372AbTDCMeM>; Thu, 3 Apr 2003 07:34:12 -0500
From: Erik Hensema <erik@hensema.net>
Subject: Re: 2.5.66-mm3
Date: Thu, 3 Apr 2003 12:45:39 +0000 (UTC)
Message-ID: <slrnb8ob7i.18d.erik@bender.home.hensema.net>
References: <20030403005817.69a29d7b.akpm@digeo.com>
Reply-To: erik@hensema.net
User-Agent: slrn/0.9.7.4 (Linux)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton (akpm@digeo.com) wrote:
> . The CPU scheduler starvation fix which was supposed to be in 2.5.66-mm2
>   actually wasn't included.  This time it's here for real.

This seems to have solved the problem for me that when I closed my
mutt-in-rxvt, the window wasn't removed from the screen for several seconds
[1], while mutt had clearly quit. Stangely enough, I only noticed this
effect when running rxvt, and only when closing the app running in it.

Anyway, when I press 'q' in mutt now, the window closes instantly, so I'm
happy ;-)

[1] on an Athlon XP 1800+ with Matrox G550
-- 
Erik Hensema <erik@hensema.net>
