Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265547AbSKFOav>; Wed, 6 Nov 2002 09:30:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265587AbSKFOav>; Wed, 6 Nov 2002 09:30:51 -0500
Received: from gate.perex.cz ([194.212.165.105]:20490 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S265547AbSKFOat>;
	Wed, 6 Nov 2002 09:30:49 -0500
Date: Wed, 6 Nov 2002 15:37:10 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Dave Jones <davej@codemonkey.org.uk>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, <ambx1@neo.rr.com>
Subject: Re: yet another update to the post-halloween doc.
In-Reply-To: <20021106140844.GA5463@suse.de>
Message-ID: <Pine.LNX.4.33.0211061526580.573-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Nov 2002, Dave Jones wrote:

> PnP layer
> ~~~~~~~~~
> - Support for plug and play devices such as early ISAPnP cards has
>   improved a lot in the 2.5 kernel. You should no longer need to
>   futz with userspace tools to configure IRQ's and the likes.
> - This code is very young, and needs more work, but is more
>   actively maintained than the previous ISAPnP work.
> - Report any regressions in plug & play functionality to
>   Adam Belay <ambx1@neo.rr.com>

Please, correct some mistakes:

- old ISA PnP code does not require user space tools, too
- the new code is mostly based on idea to make behaviour same as for PCI 
  devices (probe, remove etc. callbacks) and to merge the PnP BIOS 
  access code
- maintaince? the code was nearly complete, almost all device drivers were 
  converted to support ISA PnP (thus autoconfiguration which has moved to 
  the new PnP layer); I don't know what you mean that the code is more 
  actively maintained; it was maintained to satisfy my goals 

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com

