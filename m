Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130681AbQKRWFo>; Sat, 18 Nov 2000 17:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131356AbQKRWFd>; Sat, 18 Nov 2000 17:05:33 -0500
Received: from lsb-catv-1-p021.vtxnet.ch ([212.147.5.21]:59657 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S130681AbQKRWFU>;
	Sat, 18 Nov 2000 17:05:20 -0500
Date: Sat, 18 Nov 2000 22:34:55 +0100
From: Werner Almesberger <Werner.Almesberger@epfl.ch>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] swap=<device> kernel commandline
Message-ID: <20001118223455.G23033@almesberger.net>
In-Reply-To: <20001118141524.A15214@nic.fr> <Pine.LNX.4.21.0011181804360.9267-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0011181804360.9267-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Sat, Nov 18, 2000 at 06:05:05PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> Did you try to load an initrd on a low-memory machine?
> It shouldn't work and it probably won't ;)

You must be really low on memory ;-)

# zcat initrd.gz | wc -c
 409600

(ash, pwd, chroot, pivot_root, smount, and still about 82 kB free.)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, ICA, EPFL, CH           Werner.Almesberger@epfl.ch /
/_IN_N_032__Tel_+41_21_693_6621__Fax_+41_21_693_6610_____________________/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
