Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129996AbQKLFhK>; Sun, 12 Nov 2000 00:37:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130075AbQKLFhB>; Sun, 12 Nov 2000 00:37:01 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:56080 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129996AbQKLFgp>; Sun, 12 Nov 2000 00:36:45 -0500
From: Peter Samuelson <peter@cadcamlab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14862.11370.341594.433057@wire.cadcamlab.org>
Date: Sat, 11 Nov 2000 23:36:42 -0600 (CST)
To: "H. Peter Anvin" <hpa@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Where is it written?
In-Reply-To: <20001110184031.A2704@munchkin.spectacle-pond.org>
	<20001110192751.A2766@munchkin.spectacle-pond.org>
	<20001111163204.B6367@inspiron.suse.de>
	<20001111171749.A32100@wire.cadcamlab.org>
	<8ukkr3$f2h$1@cesium.transmeta.com>
	<20001111225428.A20749@wire.cadcamlab.org>
	<3A0E28BD.CCA5D85F@transmeta.com>
X-Mailer: VM 6.75 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
X-Face: ?*2Jm8R'OlE|+C~V>u$CARJyKMOpJ"^kNhLusXnPTFBF!#8,jH/#=Iy(?ehN$jH
        }x;J6B@[z.Ad\Be5RfNB*1>Eh.'R%u2gRj)M4blT]vu%^Qq<t}^(BOmgzRrz$[5
        -%a(sjX_"!'1WmD:^$(;$Q8~qz\;5NYji]}f.H*tZ-u1}4kJzsa@id?4rIa3^4A$
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[H. Peter Anvin <hpa@transmeta.com>]
> but the Alpha is a *much* more recent ABI... the x86 ABI really dates
> back to the 16-bit 8086-series CPUs.

Oh, right.  Xenix.  I'd forgotten.

> We might try again in 2.5 since we now have increased the minimum gcc
> version for kernel compiles.  Binutils needs no change.

You mean trivial changes to understand the ELF magic number for a
riscoid-ABI x86 object.  (You wouldn't lie to the linker and call them
SysV objects, now, would you?)  Also gdb and libbfd need to know about
stack frames.  Admittedly none of this is strictly necessary just to
link and boot a kernel.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
