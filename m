Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135855AbRD2SCh>; Sun, 29 Apr 2001 14:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135856AbRD2SC0>; Sun, 29 Apr 2001 14:02:26 -0400
Received: from e56090.upc-e.chello.nl ([213.93.56.90]:14607 "EHLO unternet.org")
	by vger.kernel.org with ESMTP id <S135855AbRD2SCR>;
	Sun, 29 Apr 2001 14:02:17 -0400
Date: Sun, 29 Apr 2001 20:01:13 +0200
From: Frank de Lange <frank@unternet.org>
To: Alexander Viro <viro@math.psu.edu>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Severe trashing in 2.4.4
Message-ID: <20010429200113.B11681@unternet.org>
In-Reply-To: <20010429194631.A11681@unternet.org> <Pine.GSO.4.21.0104291349530.2210-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0104291349530.2210-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Sun, Apr 29, 2001 at 01:58:52PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 29, 2001 at 01:58:52PM -0400, Alexander Viro wrote:
> Hmm... I'd say that you also have a leak in kmalloc()'ed stuff - something
> in 1K--2K range. From your logs it looks like the thing never shrinks and
> grows prettu fast...

Yeah, those as well. I kinda guessed they were related...

Cheers//Frank
-- 
  WWWWW      _______________________
 ## o o\    /     Frank de Lange     \
 }#   \|   /                          \
  ##---# _/     <Hacker for Hire>      \
   ####   \      +31-320-252965        /
           \    frank@unternet.org    /
            -------------------------
 [ "Omnis enim res, quae dando non deficit, dum habetur
    et non datur, nondum habetur, quomodo habenda est."  ]
