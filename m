Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129352AbQLOV6H>; Fri, 15 Dec 2000 16:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129511AbQLOV55>; Fri, 15 Dec 2000 16:57:57 -0500
Received: from lsb-catv-1-p021.vtxnet.ch ([212.147.5.21]:34576 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S129352AbQLOV5v>;
	Fri, 15 Dec 2000 16:57:51 -0500
Date: Fri, 15 Dec 2000 22:27:07 +0100
From: Werner Almesberger <Werner.Almesberger@epfl.ch>
To: Joe deBlaquiere <jadb@redhat.com>
Cc: ferret@phonewave.net, Alexander Viro <viro@math.psu.edu>,
        LA Walsh <law@sgi.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linus's include file strategy redux
Message-ID: <20001215222707.T573@almesberger.net>
In-Reply-To: <20001215152137.K599@almesberger.net> <Pine.LNX.3.96.1001215090857.16439A-100000@tarot.mentasm.org> <20001215184644.R573@almesberger.net> <3A3A7F25.2050203@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A3A7F25.2050203@redhat.com>; from jadb@redhat.com on Fri, Dec 15, 2000 at 02:29:25PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe deBlaquiere wrote:
> My solution to this has always been to make a cross compiler environment 

;-))) I think lots of people would really enjoy to have "build a
cross-gcc" added to the prerequisites for installing some driver
module ;-)

I know, it's not *that* bad. But it still adds quite a few possible
points of failure. Also, it adds a fair amount of overhead to any
directory name change or creation of a new kernel tree.

> The other advantage to this is that I can switch my host environment 
> (within reason - compatible host glibcs, ok) and not have to change the 
> target compiler.

Hmm, I don't quite understand what you mean here.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, ICA, EPFL, CH           Werner.Almesberger@epfl.ch /
/_IN_N_032__Tel_+41_21_693_6621__Fax_+41_21_693_6610_____________________/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
