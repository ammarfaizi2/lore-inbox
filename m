Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317599AbSGUOO4>; Sun, 21 Jul 2002 10:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317648AbSGUOO4>; Sun, 21 Jul 2002 10:14:56 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:21231 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S317599AbSGUOO4>; Sun, 21 Jul 2002 10:14:56 -0400
Date: Sun, 21 Jul 2002 16:17:51 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Marc-Christian Petersen <mcp@linux-systeme.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: heavy Disk I/O and system stops reacting for seconds
In-Reply-To: <200207211537.03813.mcp@linux-systeme.de>
Message-ID: <Pine.NEB.4.44.0207211613350.11656-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Jul 2002, Marc-Christian Petersen wrote:

> Hi there,
>
> I think someone else notices this too, but anyway, i write down my
> experiences.
>
> I've tested 2.4.19rc[1|2|3], AC tree, AA tree, jam tree and mjc tree
> All of them shows up the same behaviour. If i do some disk i/o, f.e.:
>
> tar xzpf linux-2.4.18.tar.gz; rm -rf linux-2.4.18
>
> the system stopps reacting while untar/ungzipping the file for more than 5
> seconds. Nothing but the mouse reacts. This does NOT occur with 2.4.18 and
> early 2.4.19-pre's ...
>...

I've seen this the first time four months ago - at that time the problem
was only present in the -ac kernels (but now it's also present in the -pre
kernels). My report is at [1]. It seems to be a problem that affects only
the handling of keyboard events. Quoting from what I wrote at [1]:

<--  snip  -->

I tried to start Gimp from the fvwm menu after I typed a letter - and
Gimp has completed its startup before the letter arrived in the xterm.

<--  snip  -->


cu
Adrian

[1] http://marc.theaimsgroup.com/?l=linux-kernel&m=101705972802903&w=2

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox


