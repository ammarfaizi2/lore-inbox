Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129563AbQKPAmJ>; Wed, 15 Nov 2000 19:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129524AbQKPAl7>; Wed, 15 Nov 2000 19:41:59 -0500
Received: from hera.cwi.nl ([192.16.191.1]:64704 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S129563AbQKPAln>;
	Wed, 15 Nov 2000 19:41:43 -0500
Date: Thu, 16 Nov 2000 01:11:38 +0100
From: Andries Brouwer <aeb@veritas.com>
To: Harald Koenig <koenig@tat.physik.uni-tuebingen.de>
Cc: emoenke@gwdg.de, eric@andante.org, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: BUG: isofs broken (2.2 and 2.4)
Message-ID: <20001116011138.A27272@veritas.com>
In-Reply-To: <20001115202344.A29136@turtle.tat.physik.uni-tuebingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001115202344.A29136@turtle.tat.physik.uni-tuebingen.de>; from koenig@tat.physik.uni-tuebingen.de on Wed, Nov 15, 2000 at 08:23:44PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2000 at 08:23:44PM +0100, Harald Koenig wrote:

> both 2.2.x and 2.4.x kernels can't read `real sky' CDs from the
> Space Telescope Science Institute containing lotsof directories (~100) 
> which each contain lots of small files (~700 files/dir).
> only ~10 directories with ~10 files each are displayed,
> all the other files/diretories can't be accessed.
> the kernel gives the following message:
> 
> 	next_offset (212) > bufsize (200)

Has there been a kernel version that could read these?
It looks like it proclaims blocksize 512 and uses blocksize 2048 or so.

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
