Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266433AbSL2Q7Q>; Sun, 29 Dec 2002 11:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266434AbSL2Q7Q>; Sun, 29 Dec 2002 11:59:16 -0500
Received: from pintail.mail.pas.earthlink.net ([207.217.120.122]:47827 "EHLO
	pintail.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S266433AbSL2Q7P>; Sun, 29 Dec 2002 11:59:15 -0500
Date: Sun, 29 Dec 2002 12:12:27 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: [2.5.53] So sloowwwww......
Message-ID: <20021229171227.GA27402@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Of course, this is little value if not possible to compare, so here
> is the same done running a kernel 2.4.20, but still compiling the
> same kernel :

>From the .config, it looks like you have a P4.  I'm not
seeing that regression on K6/2 or P3 Xeon.

k6/2 475 mhz applying patches 1-17 to linux-2.4.0.tar.bz2 and 
"make dep bzImage modules" with default options:

2.4.21-pre2aa2	1585 seconds
2.5.52bk5	1707 seconds
2.5.52bk8	1731 seconds
2.5.53-mm1	1744 seconds
2.5.53bk1	1702 seconds

Quad P3 Xeon 700 mhz applying patches 1-19 to linux-2.4.0.tar.bz2
to build 4 2.4.19 kernels simultaneously:

kernel        average time to build 4 kernels.
2.4.20-rc4      728.9 seconds
2.4.20aa1       718.9 seconds
2.5.52bk7       713.8 seconds
2.5.53-mm1      717.8 seconds

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

