Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129896AbRAJPsu>; Wed, 10 Jan 2001 10:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130110AbRAJPsl>; Wed, 10 Jan 2001 10:48:41 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:27411 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129896AbRAJPsV>; Wed, 10 Jan 2001 10:48:21 -0500
Subject: Re: Anybody got 2.4.0 running on a 386 ?
To: rob@sysgo.de (Robert Kaiser)
Date: Wed, 10 Jan 2001 15:49:34 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), richardj_moore@uk.ibm.com,
        tleete@mountain.net (Tom Leete), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0101101559230.19382-100000@dagobert.svc.sysgo.de> from "Robert Kaiser" at Jan 10, 2001 04:04:34 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14GNVJ-0000Sz-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > So called 'sigma sigma' 386 and higher. Ie we dont support the 386 with the
> > 32bit mul bugs.
> 
> Is this a new thing in 2.4.0 ? Could it possibly cause a crash as
> early as pagetable_init() ?

We've never supported pre sigmasigma cpus although someone posted a patch to
Linux 1.2 once. You won't find many of the cpus before that. At the time 386
was priced like a Xeon is now and most were recalled/pulled when the mul bug
came out. 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
