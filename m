Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131963AbQKWNhL>; Thu, 23 Nov 2000 08:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129859AbQKWNhC>; Thu, 23 Nov 2000 08:37:02 -0500
Received: from lsb-catv-1-p021.vtxnet.ch ([212.147.5.21]:64782 "EHLO
        almesberger.net") by vger.kernel.org with ESMTP id <S132484AbQKWNgu>;
        Thu, 23 Nov 2000 08:36:50 -0500
Date: Thu, 23 Nov 2000 14:06:30 +0100
From: Werner Almesberger <Werner.Almesberger@epfl.ch>
To: Michael Elizabeth Chastain <mec@shout.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: beware of dead string constants
Message-ID: <20001123140630.F599@almesberger.net>
In-Reply-To: <200011221848.MAA05565@duracef.shout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200011221848.MAA05565@duracef.shout.net>; from mec@shout.net on Wed, Nov 22, 2000 at 12:48:30PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Elizabeth Chastain wrote:
> I have a compiler from gcc.gnu.org's CVS tree that's only a few days old,
> so I can verify Jakub's claim.

BTW, do you have any estimate of how much dead string space it actually
removed ? (I.e. did the .data segment size change significantly, or was
is lost in the normal inter-gcc-version noise ?)

Just curious,
- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, ICA, EPFL, CH           Werner.Almesberger@epfl.ch /
/_IN_N_032__Tel_+41_21_693_6621__Fax_+41_21_693_6610_____________________/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
