Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129595AbRCLI2f>; Mon, 12 Mar 2001 03:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129598AbRCLI2Z>; Mon, 12 Mar 2001 03:28:25 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:21511 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129595AbRCLI2S>; Mon, 12 Mar 2001 03:28:18 -0500
From: Peter Samuelson <peter@cadcamlab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15020.34886.547537.353688@wire.cadcamlab.org>
Date: Mon, 12 Mar 2001 02:26:46 -0600 (CST)
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org, elenstev@mesatop.com,
        kbuild-devel@lists.sourceforge.net
Subject: Re: Rename all derived CONFIG variables
In-Reply-To: <20736.984380602@ocs3.ocs-net>
X-Mailer: VM 6.75 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
X-Face: ?*2Jm8R'OlE|+C~V>u$CARJyKMOpJ"^kNhLusXnPTFBF!#8,jH/#=Iy(?ehN$jH
        }x;J6B@[z.Ad\Be5RfNB*1>Eh.'R%u2gRj)M4blT]vu%^Qq<t}^(BOmgzRrz$[5
        -%a(sjX_"!'1WmD:^$(;$Q8~qz\;5NYji]}f.H*tZ-u1}4kJzsa@id?4rIa3^4A$
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[kaos]
> In 2.4.2-ac18 there are 130 CONFIG options that are always derived
> from other options, the user has no control over them.

I've thought about these before ... but never got around to doing
anything about them.  I agree they should have a separate namespace.

However, I would vote the for namespace CONFIG__* rather than
CONFIG_*_DERIVED.  As Jeff noted, _DERIVED is quite a mouthful to type,
and CONFIG__* seems all-around less intrusive.

Peter
