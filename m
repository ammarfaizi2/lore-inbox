Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290767AbSCKTsi>; Mon, 11 Mar 2002 14:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290823AbSCKTs3>; Mon, 11 Mar 2002 14:48:29 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:50189 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290767AbSCKTsL>; Mon, 11 Mar 2002 14:48:11 -0500
Subject: Re: [PATCH] 2.5.6 IDE 19, return of taskfile
To: viro@math.psu.edu (Alexander Viro)
Date: Mon, 11 Mar 2002 20:02:34 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), gunther.mayer@gmx.net (Gunther Mayer),
        andre@linuxdiskcert.org (Andre Hedrick),
        dalecki@evision-ventures.com (Martin Dalecki),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <Pine.GSO.4.21.0203111436120.14945-100000@weyl.math.psu.edu> from "Alexander Viro" at Mar 11, 2002 02:38:47 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16kW0A-0001Yl-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Umm...  By what magic?  The entire interface _is_ root-only, isn't it?
> And root can do a lot of fun stuff, starting with editing the kernel
> image...

No argument there.

Do we want to assume all raw commands are CAP_SYS_RAWIO or break them down
a bit ?
