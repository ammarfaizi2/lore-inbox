Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315463AbSEMBwr>; Sun, 12 May 2002 21:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315464AbSEMBwq>; Sun, 12 May 2002 21:52:46 -0400
Received: from mtiwmhc21.worldnet.att.net ([204.127.131.46]:52901 "EHLO
	mtiwmhc21.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S315463AbSEMBwp>; Sun, 12 May 2002 21:52:45 -0400
Date: Sun, 12 May 2002 22:10:34 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.19-pre8-ac2 kbuild 2.4 tmp_include_depends
Message-ID: <20020513021034.GA19904@lnuxlab.ath.cx>
In-Reply-To: <20819.1021169484@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: khromy@lnuxlab.ath.cx (khromy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After applying the patch pre8-ac2 still doesn't compile.

make dep
[no errors]
make bzImage
gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -o
scripts/split-include scripts/split-include.c
make: *** No rule to make target `include/linux/autoconf.h', needed by
`include/config/MARKER'.  Stop.
