Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314493AbSD1Uio>; Sun, 28 Apr 2002 16:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314495AbSD1Uio>; Sun, 28 Apr 2002 16:38:44 -0400
Received: from ns.suse.de ([213.95.15.193]:58381 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S314493AbSD1Uin>;
	Sun, 28 Apr 2002 16:38:43 -0400
Date: Sun, 28 Apr 2002 22:38:42 +0200
From: Dave Jones <davej@suse.de>
To: Alexander Hoogerhuis <alexh@ihatent.com>
Cc: rudmer@legolas.dynup.net, linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: Linux 2.5.10-dj1
Message-ID: <20020428223842.J14743@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Alexander Hoogerhuis <alexh@ihatent.com>, rudmer@legolas.dynup.net,
	linux-kernel@vger.kernel.org, vojtech@suse.cz
In-Reply-To: <20020427030823.GA21608@suse.de> <200204271313.g3RDD4024060@smtp1.wanadoo.nl> <20020427155116.I14743@suse.de> <200204281145.g3SBjJJ20178@smtp2.wanadoo.nl> <m3lmb7zjkp.fsf@lapper.ihatent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > On 2.5.10-dj1 it works like this: keyboard led is responsive to
 > hitting caps lock, but when LED is off I get upper case letter typed,
 > and when LED is off I get lower case letters. However, the strange bit
 > is that lets say I type in my username and password so that they
 > appear in lowercase on the screen, I still don't get in. And just fir
 > having tried, typing with the caps lock LED off, thus getting upper
 > case text, doesn't help either.
 > 
 > Any pointer to where I go off to track this down?

Add a #define ATKBD_DEBUG to drivers/input/keyboard/atkbd.c
and a #define I8042_DEBUG_IO to drivers/input/serio/i8042.c, and maybe
Vojtech can figure out whats going wrong from the output?

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
