Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317781AbSGKHdO>; Thu, 11 Jul 2002 03:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317785AbSGKHdN>; Thu, 11 Jul 2002 03:33:13 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:14559 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S317781AbSGKHdM>; Thu, 11 Jul 2002 03:33:12 -0400
Date: Thu, 11 Jul 2002 09:35:54 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: David Weinehall <tao@acc.umu.se>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Patch for Menuconfig script
In-Reply-To: <20020710231335.GG29001@khan.acc.umu.se>
Message-ID: <Pine.NEB.4.44.0207110925070.24665-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jul 2002, David Weinehall wrote:

>...
> Getting rid of the bash:isms everywhere is far from impossible; look at
> Debian, they are mostly there.

Nothing in the Debian policy says that packages mustn't use bash in
scripts (see section 11.4. of the Debian policy [1]) and since bash is an
essential package in Debian it's garuanteed to be available on every
Debian installation.

It isn't allowed to use bash in a script that calls
  #!/bin/sh
but if a script uses
  #!/bin/bash
instead it can use all of bash's features.

> /David

cu
Adrian

[1] http://www.debian.org/doc/debian-policy/index.html

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

