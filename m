Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130088AbRBPKM6>; Fri, 16 Feb 2001 05:12:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130255AbRBPKMs>; Fri, 16 Feb 2001 05:12:48 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:6671 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130243AbRBPKMh>; Fri, 16 Feb 2001 05:12:37 -0500
Subject: Re: out of memory?
To: ketil@froyn.com (Ketil Froyn)
Date: Fri, 16 Feb 2001 10:13:15 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0102161009230.829-100000@localhost.localdomain> from "Ketil Froyn" at Feb 16, 2001 10:37:08 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Tht7-0002jj-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> VM: do_try_to_free_pages failed for myprog.pl
> VM: do_try_to_free_pages failed for myprog.pl
> VM: do_try_to_free_pages failed for kupdate (just saw this once)
> 
> The kernel is compiled with the rh-7.0 kgcc (egcs-2.91.66), and I've
> patched it to get raid 0.90 and reiserfs 3.5.29.
> What's going on? How bad is this?

The VM logs cases where it actually ends up having trouble getting free
memory and sits around before it eventually gets life going again. Its mostly
a debugging aid and in itself harmless. 
