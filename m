Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313305AbSGDS3I>; Thu, 4 Jul 2002 14:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313416AbSGDS3H>; Thu, 4 Jul 2002 14:29:07 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:21459 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S313305AbSGDS3H>; Thu, 4 Jul 2002 14:29:07 -0400
Date: Thu, 4 Jul 2002 20:31:34 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Jochen Suckfuell <jo-lkml@suckfuell.net>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Disk IO statistics still buggy
In-Reply-To: <20020704135231.A17481@ds217-115-141-141.dedicated.hosteurope.de>
Message-ID: <Pine.NEB.4.44.0207042030350.14934-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jul 2002, Jochen Suckfuell wrote:

> Hi!

Hi Jochen!

> The IO statistics displayed in /proc/partitions are still buggy, because
> after some time, the value for the currently running requests gets too
> high or too low (see the archives, look for "/proc/partitions").
>
> Is anyone working on a fix?
>...

Marcelos' BK repository (that will become 2.4.19-rc2) includes a patch to
remove these statistics completely from /proc/partitions...

> Thanks in advance,
>
> Jochen Suckfuell

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

