Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129809AbRBYV6M>; Sun, 25 Feb 2001 16:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129816AbRBYV6C>; Sun, 25 Feb 2001 16:58:02 -0500
Received: from lsb-catv-1-p021.vtxnet.ch ([212.147.5.21]:2829 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S129809AbRBYV5z>;
	Sun, 25 Feb 2001 16:57:55 -0500
Date: Sun, 25 Feb 2001 22:57:50 +0100
From: Werner Almesberger <Werner.Almesberger@epfl.ch>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][CFT] per-process namespaces for Linux
Message-ID: <20010225225750.B19635@almesberger.net>
In-Reply-To: <3A99569F.98C64B29@storm.ca> <Pine.GSO.4.21.0102251406200.26808-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0102251406200.26808-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Sun, Feb 25, 2001 at 02:13:04PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> No kludges actually needed. "Simplified boot sequence" _is_ simplified -
> we overmount the "final" root over ramfs. Initially empty. So you have
> the normal environment when you load ramdisk, etc.

So is this the Holy Grail, err, union mount we've discussed about one year
ago ? I.e.

stat foo	# output A
mount /dev/whatever /
stat foo	# output B

with A != B ?

If yes, is there also a way to destroy/empty ramfs after this ?

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, ICA, EPFL, CH           Werner.Almesberger@epfl.ch /
/_IN_N_032__Tel_+41_21_693_6621__Fax_+41_21_693_6610_____________________/
