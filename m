Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281467AbRKUGz2>; Wed, 21 Nov 2001 01:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281631AbRKUGzS>; Wed, 21 Nov 2001 01:55:18 -0500
Received: from 24.159.204.122.roc.nc.chartermi.net ([24.159.204.122]:33549
	"EHLO tweedle.cabbey.net") by vger.kernel.org with ESMTP
	id <S281467AbRKUGzF>; Wed, 21 Nov 2001 01:55:05 -0500
Date: Wed, 21 Nov 2001 00:54:02 -0600 (CST)
From: Chris Abbey <linux@cabbey.net>
X-X-Sender: <cabbey@tweedle.cabbey.net>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [VM/MEMORY-SICKNESS] 2.4.15-pre7 kmem_cache_create invalid opcode
In-Reply-To: <20011121003304.A683@vger.timpanogas.org>
Message-ID: <Pine.LNX.4.33.0111210046440.3730-100000@tweedle.cabbey.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Today, Jeff V. Merkey wrote:
> [...] I went back
> over how I did the build, and this is the result of the build
> if you have unpacked, patched, then run "make oldconfig."  If I
> do a "make dep" then this problem does not occur, [....]

umm... lemme see if I understand you correctly, you patched the
kernel and soemthing breaks if you don't run make dep after
patching? Unless you can prove 100% that nothing in that
patch affects the dependency structure of the code, nor any of
the other things that are generated during the make dep stage,
then what we have here is user error. The directions say, quite
clearly, make oldconfig, make dep, make vmlinux, etc. Unless my
memory is totally shot tonight the last thing make oldconfig
spits out is in fact the direction to run make dep.

