Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267098AbSL3XCl>; Mon, 30 Dec 2002 18:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267099AbSL3XCk>; Mon, 30 Dec 2002 18:02:40 -0500
Received: from smtp.comcast.net ([24.153.64.2]:31852 "EHLO smtp.comcast.net")
	by vger.kernel.org with ESMTP id <S267098AbSL3XCj>;
	Mon, 30 Dec 2002 18:02:39 -0500
Date: Mon, 30 Dec 2002 18:10:58 -0500
From: Tom Vier <tmv@comcast.net>
Subject: Re: es1371 driver: ensoniq 5880 distortion
In-reply-to: <0H7V00I4HQ3B7O@mtain07.icomcast.net>
To: linux-kernel@vger.kernel.org
Reply-to: Tom Vier <tmv@comcast.net>
Message-id: <20021230231058.GB2686@yzero>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.3.28i
References: <20021229011355.GA2395@yzero> <0H7V00I4HQ3B7O@mtain07.icomcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 29, 2002 at 12:47:40PM +0100, Rudmer van Dijk wrote:
> On Sunday 29 December 2002 02:13, Tom Vier wrote:
> > i have an sb card that uses a 5880. all output from the card is distorted,
> > regardless of which output i use, what volume i set the card at, and what i
> > play (cat english.au and xmms playing mp3s).
> 
> this is my soundcard (from lspci -v):
> 00:0f.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
>         Subsystem: Ensoniq Creative Sound Blaster AudioPCI128

exactly the same as mine.

>         Flags: bus master, slow devsel, latency 64, IRQ 5
>         I/O ports at d800 [size=64]
>         Capabilities: <available only to root>
> 
> I'm using alsa on 2.5.5x and alsa-0.9 on 2.4.2x and all works fine... so what 
> kernel(s) are you using and do you have OSS or ALSA drivers??

2.4.20 to 21-pre2. alsa, i guess. in menuconfig, i just selected sound card
support (CONFIG_SOUND) and es1371 support (CONFIG_SOUND_ES1371).
CONFIG_SOUND_OSS is not set.

-- 
Tom Vier <tmv@comcast.net>
DSA Key ID 0xE6CB97DA
