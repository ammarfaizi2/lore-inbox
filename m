Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbQL0Mc4>; Wed, 27 Dec 2000 07:32:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129383AbQL0Mcq>; Wed, 27 Dec 2000 07:32:46 -0500
Received: from oracle.clara.net ([195.8.69.94]:16145 "EHLO oracle.clara.net")
	by vger.kernel.org with ESMTP id <S129267AbQL0Mcj>;
	Wed, 27 Dec 2000 07:32:39 -0500
Date: Wed, 27 Dec 2000 11:58:24 +0000 (GMT)
From: Dave Gilbert <gilbertd@treblig.org>
To: Christoph Rohland <cr@sap.com>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] shmmin behaviour back to 2.2 behaviour
In-Reply-To: <m3d7eeb1pa.fsf@linux.local>
Message-ID: <Pine.LNX.4.10.10012271156200.2753-100000@tardis.home.dave>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Dec 2000, Christoph Rohland wrote:

> Hi Linus,
> 
> The following patchlet bring the handling of shmget with size zero
> back to the 2.2 behaviour. There seem to be programs out, which
> (erroneously) rely on this.

Hi Christoph,
  I think I've come to the conclusion that Xine does not in the case I've
found, rely on this - it is a separate bug related to Xv telling xine that
it needs 0 bytes.

Dave

-- 
 ---------------- Have a happy GNU millennium! ----------------------   
/ Dr. David Alan Gilbert      | Running GNU/Linux on       |  Happy  \ 
\   gro.gilbert @ treblig.org |  Alpha, x86, ARM and SPARC |  In Hex /
 \ ___________________________|___ http://www.treblig.org  |________/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
