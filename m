Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132326AbRCZGJk>; Mon, 26 Mar 2001 01:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132327AbRCZGJ3>; Mon, 26 Mar 2001 01:09:29 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:16389 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S132326AbRCZGJP>; Mon, 26 Mar 2001 01:09:15 -0500
From: Peter Samuelson <peter@cadcamlab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15038.56527.591553.87791@wire.cadcamlab.org>
Date: Mon, 26 Mar 2001 00:08:15 -0600 (CST)
To: "Eric S. Raymond" <esr@snark.thyrsus.com>
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: CML1 cleanup patch
In-Reply-To: <200103260001.f2Q01Yt09387@snark.thyrsus.com>
X-Mailer: VM 6.75 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
X-Face: ?*2Jm8R'OlE|+C~V>u$CARJyKMOpJ"^kNhLusXnPTFBF!#8,jH/#=Iy(?ehN$jH
        }x;J6B@[z.Ad\Be5RfNB*1>Eh.'R%u2gRj)M4blT]vu%^Qq<t}^(BOmgzRrz$[5
        -%a(sjX_"!'1WmD:^$(;$Q8~qz\;5NYji]}f.H*tZ-u1}4kJzsa@id?4rIa3^4A$
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[esr]
> CONFIG_8139TOO			CONFIG_RTL8139TOO
> CONFIG_8139TOO_PIO		CONFIG_RTL8139TOO_PIO
> CONFIG_8139TOO_TUNE_TWISTER	CONFIG_RTL8139TOO_TUNE_TWISTER

The -TOO suffix was to distinguish between this and the former 8139
driver, as the two coexisted in 2.2 and 2.3.  As the old driver has
been dropped from 2.4, I propose likewise dropping the -TOO.

Oh, BTW -- an alternate approach to making the kernel tree compatible
with CML2 would be to make CML2 compatible with the kernel tree.
Define a character (say '%') as an optional prefix for a configuration
symbol.  This character would only be required where the symbol would
otherwise by misparsed, as with '[0-9].*'.

Peter
