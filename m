Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319022AbSH1VEL>; Wed, 28 Aug 2002 17:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319023AbSH1VEK>; Wed, 28 Aug 2002 17:04:10 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:25843 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S319022AbSH1VEJ>; Wed, 28 Aug 2002 17:04:09 -0400
Date: Wed, 28 Aug 2002 23:08:24 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Bjoern Krombholz <bjkro@gmx.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Oops while accessing /proc/stat (2.4.19)
In-Reply-To: <20020826145124.GA16273@wh8043.stw.uni-rostock.de>
Message-ID: <Pine.NEB.4.44.0208282306490.2879-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Aug 2002, Bjoern Krombholz wrote:

> Hello,

Hi Bjoern,

> i'm currently have a problem that every program that tries to read from
> /proc/stat like `uptime', `free', `cat /proc/stat' etc. segfaults.
>...
> kernel: c01f2ad9
> kernel: Oops: 0002
> kernel: CPU:    0
> kernel: EIP:    0010:[number+1049/1088]    Tainted: PF
>...

which binary-only modules (e.g. NVidia) are loaded on your computer? Is
the problem reproducible without them ever loaded since the last reboot?

> Thx,
> Bjoern Krombholz

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

