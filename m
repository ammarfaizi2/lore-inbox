Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130472AbRCILsL>; Fri, 9 Mar 2001 06:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130489AbRCILsB>; Fri, 9 Mar 2001 06:48:01 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:24082 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130472AbRCILrw>; Fri, 9 Mar 2001 06:47:52 -0500
Subject: Re: quicksort for linked list
To: bruce+@andrew.cmu.edu (James R Bruce)
Date: Fri, 9 Mar 2001 11:50:44 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <kue=bLNz000142mEtL@andrew.cmu.edu> from "James R Bruce" at Mar 09, 2001 06:09:11 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14bLPz-0004r4-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Quicksort works just fine on a linked list, as long as you broaden
> your view beyond the common array-based implementations.  See
> "http://www.cs.cmu.edu/~jbruce/sort.cc" for an example, although I
> would recommend using a radix sort for linked lists in most situations
> (sorry for the C++, but it was handy...).

In a network environment however its not so good. Quicksort has an N^2
worst case and the input is controlled by a potential enemy.

Im dubious about anyone doing more than simple bucket sorting for packets.

