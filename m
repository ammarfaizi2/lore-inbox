Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261173AbSLPX3h>; Mon, 16 Dec 2002 18:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261205AbSLPX3h>; Mon, 16 Dec 2002 18:29:37 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:26705
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S261173AbSLPX3g>; Mon, 16 Dec 2002 18:29:36 -0500
Date: Mon, 16 Dec 2002 18:39:58 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Rusty Russell <rusty@rustcorp.com.au>
cc: vamsi@in.ibm.com, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] module-init-tools 0.9.3, rmmod modules with '-' 
In-Reply-To: <20021216214023.624E32C27B@lists.samba.org>
Message-ID: <Pine.LNX.4.50.0212161831340.1804-100000@montezuma.mastecende.com>
References: <20021216214023.624E32C27B@lists.samba.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Dec 2002, Rusty Russell wrote:

> How did you get a module which has - in its name?  The build system
> *should* turn them into _'s.

ALSA modules?

-rw-r--r--    1 root     root       170125 Dec 15 00:10 snd-mixer-oss.ko
-rw-r--r--    1 root     root       143685 Dec 15 00:10 snd-mpu401-uart.ko
-rw-r--r--    1 root     root       312564 Dec 15 00:10 snd-opl3-lib.ko
-rw-r--r--    1 root     root       194307 Dec 15 00:10 snd-opl3sa2.ko
-rw-r--r--    1 root     root       612512 Dec 15 00:10 snd-opl3-synth.ko
-rw-r--r--    1 root     root      1160272 Dec 15 00:10 snd-pcm.ko

But they do get converted when we load ie snd-pcm turns into snd_pcm

-- 
function.linuxpower.ca
