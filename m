Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317101AbSGCRXi>; Wed, 3 Jul 2002 13:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317102AbSGCRXh>; Wed, 3 Jul 2002 13:23:37 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:8426 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S317101AbSGCRXe>; Wed, 3 Jul 2002 13:23:34 -0400
Date: Wed, 3 Jul 2002 19:25:59 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Ulrich Wiederhold <U.Wiederhold@gmx.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-rc1 and devfs
In-Reply-To: <20020703164004.GB10269@sky.net>
Message-ID: <Pine.NEB.4.44.0207031856540.14934-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jul 2002, Ulrich Wiederhold wrote:

>...
> > 2. Your .config
> Hmmm, I don't know whether to attach or to paste it, I think to attach
> is better, so it's attached.

<--  snip  -->

...
# CONFIG_MTRR=y
...
CONFIG_SCSI_DEBUG_QUEUES=Y
...
#CONFIG_EXT3_FS=y
#CONFIG_JBD=y
...
#CONFIG_RAMFS=y
...
# CONFIG_SOUND_BT878=m
...

<--  snip  -->

It does _NOT_ work to edit a .config by hand without running a
"make oldconfig" after editing it.

After running "make oldconfig" 2.4.19-rc1 compiles fine with your .config

> Uli

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox



