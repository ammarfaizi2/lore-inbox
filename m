Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130038AbRBYMmo>; Sun, 25 Feb 2001 07:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129896AbRBYMmf>; Sun, 25 Feb 2001 07:42:35 -0500
Received: from lsb-catv-1-p021.vtxnet.ch ([212.147.5.21]:42252 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S130038AbRBYMmT>;
	Sun, 25 Feb 2001 07:42:19 -0500
Date: Sun, 25 Feb 2001 13:41:56 +0100
From: Werner Almesberger <Werner.Almesberger@epfl.ch>
To: Chris Wedgwood <cw@f00f.org>
Cc: netdev@oss.sgi.com,
        Linux Knernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: New net features for added performance
Message-ID: <20010225134156.K18271@almesberger.net>
In-Reply-To: <3A9842DC.B42ECD7A@mandrakesoft.com> <3A986EDB.363639E7@coplanar.net> <20010225162357.A12123@metastasis.f00f.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010225162357.A12123@metastasis.f00f.org>; from cw@f00f.org on Sun, Feb 25, 2001 at 04:23:57PM +1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> That said, it would be an extemely neat thing to do from a technical
> perspective, but I don't know if you would ever get really good
> performance from it.

Well, you'd have to re-design the networking code to support NUMA
architectures, with a fairly fine granularity. I'm not sure you'd gain
anything except possibly for the forwarding fast path.

A cheaper, and probably more useful possibility is hardware assistance for
specific operations. E.g. hardware-accelerated packet classification looks
interesting. I'd also like to see hardware-assistance for shaping on other
media than ATM.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, ICA, EPFL, CH           Werner.Almesberger@epfl.ch /
/_IN_N_032__Tel_+41_21_693_6621__Fax_+41_21_693_6610_____________________/
