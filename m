Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285589AbRLWIHQ>; Sun, 23 Dec 2001 03:07:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285590AbRLWIG5>; Sun, 23 Dec 2001 03:06:57 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:1042 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S285585AbRLWIGj>; Sun, 23 Dec 2001 03:06:39 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Booting a modular kernel through a multiple streams file
Date: 23 Dec 2001 00:06:08 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a0439g$7a5$1@cesium.transmeta.com>
In-Reply-To: <E16I1Yc-0003eD-00@schizo.psychosis.com> <E16I2rw-0006zi-00@sites.inka.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <E16I2rw-0006zi-00@sites.inka.de>
By author:    Bernd Eckenfels <usenet2001-12@lina.inka.de>
In newsgroup: linux.dev.kernel
> 
> > How many times have you seen ANYTHING ditributed that way?
> 
> AFAIK cpio is quite common on SysV Systems. The Problem with cpio and tar is,
> that there are many incompatible versions. Even the Posix.1 format is quite
> limited (255 char path limit).

This is the POSIX.1 *TAR* format.  The POSIX.1 *CPIO* format doesn't
have this limitation.

>  Some others fail short with symlinks or block
> device nodes.

Only utterly archaic versions, never used on Linux.

> AFAIK SUS is supporting the use of pax.
> 
> http://www.opengroup.org/onlinepubs/7908799/xcu/pax.html 

Pax is just a single utility which does cpio and tar.

Al is using a specific cpio format, which I believe is either the
"newc" or "odc" format... Al?

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
