Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282817AbRLQU0j>; Mon, 17 Dec 2001 15:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282771AbRLQU0T>; Mon, 17 Dec 2001 15:26:19 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:1770 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S282707AbRLQU0S>; Mon, 17 Dec 2001 15:26:18 -0500
Date: Mon, 17 Dec 2001 21:26:10 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Simon Roscic <simon.roscic@chello.at>
cc: linux-kernel@vger.kernel.org
Subject: Re: compile problem: es1371+gamepad
In-Reply-To: <Pine.NEB.4.43.0112172057360.24574-100000@mimas.fachschaften.tu-muenchen.de>
Message-ID: <Pine.NEB.4.43.0112172114170.24574-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2001, Adrian Bunk wrote:

>...
> Simon: As an (untested) workaround until the bug I describe below is fixed
>        it should work for you if select in the Character devices/Joysticks
>        submenu the "Game port support" to be compiled statically into the
>        kernel instead of compiling it as a module.
>...

An addition to this (I should have tested it before I sent the mail...):
To do this you need to compile "Input core support" in the submenu with
the same name static instead of modular into the kernel.

cu
Adrian

-- 

Get my GPG key: finger bunk@debian.org | gpg --import

Fingerprint: B29C E71E FE19 6755 5C8A  84D4 99FC EA98 4F12 B400


