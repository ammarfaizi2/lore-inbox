Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281823AbRKQXOJ>; Sat, 17 Nov 2001 18:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281728AbRKQXN6>; Sat, 17 Nov 2001 18:13:58 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:57841 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S281823AbRKQXNq>; Sat, 17 Nov 2001 18:13:46 -0500
Date: Sun, 18 Nov 2001 00:13:38 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Steve Martin <ecprod@bellsouth.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.14 loop.o missing symbol
In-Reply-To: <3BF6CE2B.857A2AEB@bellsouth.net>
Message-ID: <Pine.NEB.4.40.0111180012530.1826-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Nov 2001, Steve Martin wrote:

> FYI: in kernel 2.4.14, symbol "deactivate_page()"
> is not exported from kernel/ksyms.c, causing
> unresolved reference in drivers/block/loop.c

This is a known bug (and the right solution is to remove the two lines
that contain deactivate_page from drivers/block/loop.c).

cu
Adrian

-- 

Get my GPG key: finger bunk@debian.org | gpg --import

Fingerprint: B29C E71E FE19 6755 5C8A  84D4 99FC EA98 4F12 B400

