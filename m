Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314689AbSD1WrT>; Sun, 28 Apr 2002 18:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314690AbSD1WrS>; Sun, 28 Apr 2002 18:47:18 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:18606 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S314689AbSD1WrR>;
	Sun, 28 Apr 2002 18:47:17 -0400
Date: Mon, 29 Apr 2002 00:47:07 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dave Jones <davej@suse.de>, Alexander Hoogerhuis <alexh@ihatent.com>,
        rudmer@legolas.dynup.net, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.10-dj1
Message-ID: <20020429004707.D12673@ucw.cz>
In-Reply-To: <20020427030823.GA21608@suse.de> <200204271313.g3RDD4024060@smtp1.wanadoo.nl> <20020427155116.I14743@suse.de> <200204281145.g3SBjJJ20178@smtp2.wanadoo.nl> <m3lmb7zjkp.fsf@lapper.ihatent.com> <20020428223842.J14743@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 28, 2002 at 10:38:42PM +0200, Dave Jones wrote:

>  > On 2.5.10-dj1 it works like this: keyboard led is responsive to
>  > hitting caps lock, but when LED is off I get upper case letter typed,
>  > and when LED is off I get lower case letters. However, the strange bit
>  > is that lets say I type in my username and password so that they
>  > appear in lowercase on the screen, I still don't get in. And just fir
>  > having tried, typing with the caps lock LED off, thus getting upper
>  > case text, doesn't help either.
>  > 
>  > Any pointer to where I go off to track this down?
> 
> Add a #define ATKBD_DEBUG to drivers/input/keyboard/atkbd.c
> and a #define I8042_DEBUG_IO to drivers/input/serio/i8042.c, and maybe
> Vojtech can figure out whats going wrong from the output?

Sure, I'll help where I can. What keyboard/computer is this?

-- 
Vojtech Pavlik
SuSE Labs
