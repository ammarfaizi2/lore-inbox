Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135728AbRAJTrT>; Wed, 10 Jan 2001 14:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135889AbRAJTrL>; Wed, 10 Jan 2001 14:47:11 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:18437 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135728AbRAJTrA>; Wed, 10 Jan 2001 14:47:00 -0500
Subject: Re: Subtle MM bug
To: ak@suse.de (Andi Kleen)
Date: Wed, 10 Jan 2001 19:48:04 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), ak@suse.de (Andi Kleen),
        trond.myklebust@fys.uio.no (Trond Myklebust),
        phillips@innominate.de (Daniel Phillips),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <20010110204308.A5303@gruyere.muc.suse.de> from "Andi Kleen" at Jan 10, 2001 08:43:08 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14GRE7-0000p5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As the thread started it's not only only needed for pthreads, but also for NFS
> and setuid (actually NFS already implements it privately), and probably other network
> file systems too.  So it's far from being only a "bad standard corner case". 

I wonder how Linux 2.2 worked, that doesnt have them. Now if its a clean way
of sorting out a pile of other things and it does pthreads as a side effect
I've no problem, but arguing for it because of a tiny pthreads corner case
is coming from the wrong end

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
