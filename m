Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136918AbRA2CEj>; Sun, 28 Jan 2001 21:04:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S144905AbRA2CEb>; Sun, 28 Jan 2001 21:04:31 -0500
Received: from ferret.lmh.ox.ac.uk ([163.1.138.204]:43782 "HELO
	ferret.lmh.ox.ac.uk") by vger.kernel.org with SMTP
	id <S137010AbRA2CEQ>; Sun, 28 Jan 2001 21:04:16 -0500
Date: Mon, 29 Jan 2001 02:04:15 +0000 (GMT)
From: Chris Evans <chris@scary.beasts.org>
To: <Tony.Young@ir.com>
cc: <slug@slug.org.au>, <csa@oss.sgi.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux Disk Performance/File IO per process
In-Reply-To: <C0D2F5944500D411AD8A00104B31930E108096@ir_nt_server2>
Message-ID: <Pine.LNX.4.30.0101290200220.21841-100000@ferret.lmh.ox.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 29 Jan 2001 Tony.Young@ir.com wrote:

> All,
>
> I work for a company that develops a systems and performance management
> product for Unix (as well as PC and TANDEM) called PROGNOSIS. Currently we
> support AIX, HP, Solaris, UnixWare, IRIX, and Linux.
>
> I've hit a bit of a wall trying to expand the data provided by our Linux
> solution - I can't seem to find anywhere that provides the metrics needed to
> calculate disk busy in the kernel! This is a major piece of information that
> any mission critical system administrator needs to successfully monitor
> their systems.

Stephen Tweedie has a rather funky i/o stats enhancement patch which
should provide what you need. It comes with RedHat7.0 and gives decent
disk statistics in /proc/partitions.

Unfortunately this patch is not yet in the 2.2 or 2.4 kernel. I'd like to
see it make the kernel as a 2.4.x item. Failing that, it'll probably make
the 2.5 kernel.

Cheers
Chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
