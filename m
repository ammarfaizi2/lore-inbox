Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267373AbRGPN2M>; Mon, 16 Jul 2001 09:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267376AbRGPN1w>; Mon, 16 Jul 2001 09:27:52 -0400
Received: from Morgoth.esiway.net ([193.194.16.157]:42500 "EHLO
	Morgoth.esiway.net") by vger.kernel.org with ESMTP
	id <S267373AbRGPN1t>; Mon, 16 Jul 2001 09:27:49 -0400
Date: Mon, 16 Jul 2001 15:27:46 +0200 (CEST)
From: Marco Colombo <marco@esi.it>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Stability of ReiserFS onj Kernel 2.4.x (sp. 2.4.[56]{-ac*}
In-Reply-To: <E15Lp2T-0004DQ-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0107161522400.21400-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Jul 2001, Alan Cox wrote:

> > > Ext2 handles files larger than 2Gb, and can handle up to about 1Tb per volume
> > > which is the block layer fs size limit.
> > >
> > The limits for reiserfs and ext2 for kernels 2.4.x are the same (and they are 2Tb not 1Tb).  The
> > limits are not in the individual filesystems.  We need to have Linux go to 64 bit blocknumbers in
>
> Its 1 terabyte - there are some unclean sign bit abuses

Is this true also on 64-bits archs (Alpha, UltraSparc)? I guess limits
listed in Documentation/filesystems/ext2.txt assume 32 bits.

.TM.
-- 
      ____/  ____/   /
     /      /       /			Marco Colombo
    ___/  ___  /   /		      Technical Manager
   /          /   /			 ESI s.r.l.
 _____/ _____/  _/		       Colombo@ESI.it

