Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266794AbSLPQQG>; Mon, 16 Dec 2002 11:16:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266796AbSLPQQG>; Mon, 16 Dec 2002 11:16:06 -0500
Received: from rivmkt61.wintek.com ([206.230.0.61]:128 "EHLO comcast.net")
	by vger.kernel.org with ESMTP id <S266794AbSLPQQF>;
	Mon, 16 Dec 2002 11:16:05 -0500
Date: Mon, 16 Dec 2002 11:19:00 +0000 (UTC)
From: Alex Goddard <agoddard@purdue.edu>
To: Gregoire Favre <greg@ulima.unil.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.52 and modules (lots of unresolved symbols)?
In-Reply-To: <20021216094514.GA735@ulima.unil.ch>
Message-ID: <Pine.LNX.4.50L0.0212161114360.1154-100000@dust.ebiz-gw.wintek.com>
References: <20021216094514.GA735@ulima.unil.ch>
X-GPG-PUBLIC_KEY: N/a
X-GPG-FINGERPRINT: BCBC 0868 DB78 22F3 A657 785D 6E3B 7ACB 584E B835
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Dec 2002, Gregoire Favre wrote:

> Hello,
> 
> I have just patched 2.5.51, and not done the make clean && make mrproper
> before doing a make menuconfig && make dep && make bzImage && make
> modules...
> 
> Will that change anything to make clean/mrproper here?

I would give 'make clean' a try.
 
> I have module-init-tools-0.9.3 compiled and installed on my system.

I got the same thing (a shitload of depmod unresolved symbols messages) 
when i first tried compiling 2.5.52.  It stopped when I reinstalled 
module-init-tools, and built and the kernel again after a 'make clean'.

-- 
Alex Goddard
agoddard@purdue.edu
