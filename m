Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133052AbRALVIU>; Fri, 12 Jan 2001 16:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135285AbRALVIK>; Fri, 12 Jan 2001 16:08:10 -0500
Received: from e56090.upc-e.chello.nl ([213.93.56.90]:50701 "EHLO unternet.org")
	by vger.kernel.org with ESMTP id <S133052AbRALVIC>;
	Fri, 12 Jan 2001 16:08:02 -0500
Date: Fri, 12 Jan 2001 22:07:29 +0100
From: Frank de Lange <frank@unternet.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: mingo@elte.hu, Linus Torvalds <torvalds@transmeta.com>,
        dwmw2@infradead.org, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardwarerelated?
Message-ID: <20010112220729.D27809@unternet.org>
In-Reply-To: <Pine.LNX.4.30.0101122136180.2772-100000@e2> <3A5F6F07.88564D5B@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A5F6F07.88564D5B@colorfullife.com>; from manfred@colorfullife.com on Fri, Jan 12, 2001 at 09:54:31PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2001 at 09:54:31PM +0100, Manfred Spraul wrote:
> I have found one combination that doesn't hang with the unpatched
> 8390.c, but network throughput is down to 1/2. I hope that's due to the
> debugging changes.

Hm, could it be that the fact that network throughput is halved causes the
problem not to appear? Remember, it only appears under HEAVY network load. A
single nfs cp -rd <big_dir> was not enough to hang my network, I needed to add
at least another cp -rd or some streaming audio or something else...

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
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
