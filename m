Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131408AbRDMP2k>; Fri, 13 Apr 2001 11:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131407AbRDMP2b>; Fri, 13 Apr 2001 11:28:31 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:34060 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131386AbRDMP2P>; Fri, 13 Apr 2001 11:28:15 -0400
Subject: Re: Problem with k7 optimizations in 2.4.x?
To: moses@texoma.net (Moses Mcknight)
Date: Fri, 13 Apr 2001 16:30:16 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3AD706C4.8020705@texoma.net> from "Moses Mcknight" at Apr 13, 2001 09:01:40 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14o5Wc-000336-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> settings or what, but whenever I try to run a 2.4.x kernel on my machine 
> with k7 optimizations the computer will never fully boot and seems to 
> give random errors about being "unable to handle kernel NULL pointer 
> dereference at virtual address xxxxxxxx" and other errors.

I run the K7 optimisations in 2.4.x-ac built with gcc 2.96-69 or later with no
problems. I've not tested them with egcs-1.1.2. The earlier 2.4.* had problems
on later Athlons which have both fxsave and movntq/sfence. That was fixed a 
while back tho

