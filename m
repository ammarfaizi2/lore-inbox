Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314681AbSD2M74>; Mon, 29 Apr 2002 08:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315154AbSD2M7z>; Mon, 29 Apr 2002 08:59:55 -0400
Received: from Expansa.sns.it ([192.167.206.189]:42246 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S314681AbSD2M7y>;
	Mon, 29 Apr 2002 08:59:54 -0400
Date: Mon, 29 Apr 2002 14:59:52 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: linux-kernel@vger.kernel.org
Subject: 2.5.11 unix.o unresolved symbol (compiled as module)
Message-ID: <Pine.LNX.4.44.0204291448340.4783-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


HI,
I was just compiling kernel 2.5.11.
compiling this kernel with unix.o and nfsd.o as modules,
then modprobe gives me the message

unresolved symbol  path_lookup

Please note that compiling them statically does work.

loading the module exportfs.o does taint the kernel (??)



More, the system hangs at boot befor init runs agetty.

Hope this helps
Luigi


