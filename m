Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135681AbRAQUrW>; Wed, 17 Jan 2001 15:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133095AbRAQUrL>; Wed, 17 Jan 2001 15:47:11 -0500
Received: from lsb-catv-1-p021.vtxnet.ch ([212.147.5.21]:2834 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S130643AbRAQUq6>;
	Wed, 17 Jan 2001 15:46:58 -0500
Date: Wed, 17 Jan 2001 21:46:50 +0100
From: Werner Almesberger <Werner.Almesberger@epfl.ch>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Linux not adhering to BIOS Drive boot order?
Message-ID: <20010117214650.Q18286@almesberger.net>
In-Reply-To: <1355693A51C0D211B55A00105ACCFE64E95191@ATL_MS1> <Pine.LNX.4.21.0101161154580.17397-100000@sol.compendium-tech.com> <20010117202222.B4979@almesberger.net> <20010117223206.H25659@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010117223206.H25659@mea-ext.zmailer.org>; from matti.aarnio@zmailer.org on Wed, Jan 17, 2001 at 10:32:06PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matti Aarnio wrote:
>   2.4.0 with devfs mounted at boot time into /dev/

Or /proc/partitions, which - according to the mount(8) man page - has
been around since 2.1.116. So we're not exactly talking crazy upgrade
paths here.

>   This new style (which contains, hopefully, physical PCI location)
>   mount device paths will failry easily handle question about which
>   is where...   And the partitions are PHYSICAL partition numbers,

Hmm, without PCI locations, you still need to know how the system
determines which interface becomes host0. Also, PCI locations
probably aren't the most user-friendly way for identifying things ;-)

But for the occasional problem case where label or uuid don't work,
any such information is, of course, valuable.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, ICA, EPFL, CH           Werner.Almesberger@epfl.ch /
/_IN_N_032__Tel_+41_21_693_6621__Fax_+41_21_693_6610_____________________/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
