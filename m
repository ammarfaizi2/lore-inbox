Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133092AbRDRL6B>; Wed, 18 Apr 2001 07:58:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133093AbRDRL5v>; Wed, 18 Apr 2001 07:57:51 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:26629 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S133092AbRDRL5j>; Wed, 18 Apr 2001 07:57:39 -0400
Subject: Re: Kernel 2.5 Workshop RealVideo streams -- next time, please get better audio.
To: acahalan@cs.uml.edu (Albert D. Cahalan)
Date: Wed, 18 Apr 2001 12:58:31 +0100 (BST)
Cc: tytso@mit.edu (Theodore Tso), davem@redhat.com (David S. Miller),
        miles@megapathdsl.net (Miles Lane), linux-kernel@vger.kernel.org
In-Reply-To: <200104180246.f3I2kL1192784@saturn.cs.uml.edu> from "Albert D. Cahalan" at Apr 17, 2001 10:46:20 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14pqbS-0004YM-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Being an outsider, I'm still trying to find out WTF happened
> on friday evening when NUMA was discussed. I can't find any
> video, audio, or even technical notes. This sucks; I'm writing
> support for NUMA hardware (it's not cache coherent) right now
> and I don't have any idea where things will be going.

Something like

View 1:	(The SGI view)
	NUMA should be implemented as a single kernel on a numa system. Andrea
has done some work on this (see his kernel.org patches), as have SGI.

View 2: (The McVoy view)
	NUMA is best viewed as another misguided attempt to do DSM and we
should run a kernel on each DSM node and do page cache borrows between nodes.

Alan

