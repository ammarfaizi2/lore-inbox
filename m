Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263055AbSJBLoa>; Wed, 2 Oct 2002 07:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263058AbSJBLo3>; Wed, 2 Oct 2002 07:44:29 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:16350 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S263055AbSJBLo2>; Wed, 2 Oct 2002 07:44:28 -0400
Date: Wed, 2 Oct 2002 13:49:46 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Pavel Machek <pavel@ucw.cz>
cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Swsusp updates, do not thrash ide disk on suspend
In-Reply-To: <20021001222434.GA2498@elf.ucw.cz>
Message-ID: <Pine.NEB.4.44.0210021347090.10143-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Oct 2002, Pavel Machek wrote:

>...
> --- clean/Documentation/swsusp.txt	2002-07-09 04:54:06.000000000 +0200
> +++ linux-swsusp/Documentation/swsusp.txt	2002-09-25 21:14:42.000000000 +0200
> @@ -156,6 +156,23 @@
>  - do IDE cdroms need some kind of support?
>  - IDE CD-RW -- how to deal with that?
>
> +FAQ:
> +
> +Q: well, suspending a server is IMHO a really stupid thing,
> +but... (Diego Zuccato):
>...
> +Ethernet card in your server died. You want to replace it. Your
> +server is not hotplug capable. What do you do? Suspend to disk,
> +replace ethernet card, resume. If you are fast your users will not
> +even see broken connections.
>...

This sounds as if it might makes even ISA cards hot-pluggable with the
implication that the drivers might need __devinit/__devexit etc.?

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

