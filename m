Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129752AbQLRGmk>; Mon, 18 Dec 2000 01:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129557AbQLRGma>; Mon, 18 Dec 2000 01:42:30 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:5386 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129421AbQLRGmT>; Mon, 18 Dec 2000 01:42:19 -0500
Date: Mon, 18 Dec 2000 00:11:35 -0600
To: Mikael Djurfeldt <djurfeldt@nada.kth.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test13-pre3: Makefile problem in drivers/video
Message-ID: <20001218001135.Z3199@cadcamlab.org>
In-Reply-To: <E147oeY-0006H7-00@mdj.nada.kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E147oeY-0006H7-00@mdj.nada.kth.se>; from mdj@mdj.nada.kth.se on Mon, Dec 18, 2000 at 01:59:46AM +0100
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Mikael Djurfeldt]
> When trying to build video.o as a module, video.o doesn't get copied
> to /lib/modules/* during installation.

There is no video.o module.  If video.o is built at all, it is linked
into the vmlinux image directly.  The modules in that directory will be
atyfb.o, tdfxfb.o and about 800 others.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
