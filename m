Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262885AbSJLLRy>; Sat, 12 Oct 2002 07:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262886AbSJLLRy>; Sat, 12 Oct 2002 07:17:54 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:1458 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262885AbSJLLRy>; Sat, 12 Oct 2002 07:17:54 -0400
Subject: Re: 2.5.42: stallion.c doesn't compile
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.NEB.4.44.0210121215370.8340-100000@mimas.fachschaften.tu-muenchen.de>
References: <Pine.NEB.4.44.0210121215370.8340-100000@mimas.fachschaften.tu-muenchen.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 12 Oct 2002 12:35:29 +0100
Message-Id: <1034422529.14297.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-10-12 at 11:21, Adrian Bunk wrote:
> drivers/char/stallion.c: In function `stl_initports':
> drivers/char/stallion.c:2294: structure has no member named `routine'
> ...
> make[2]: *** [drivers/char/stallion.o] Error 1

You probably need to swap it for "func". Check workqueue.h

