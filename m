Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132338AbRDUAbB>; Fri, 20 Apr 2001 20:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132352AbRDUAav>; Fri, 20 Apr 2001 20:30:51 -0400
Received: from stanis.onastick.net ([207.96.1.49]:36874 "EHLO
	stanis.onastick.net") by vger.kernel.org with ESMTP
	id <S132338AbRDUAaj>; Fri, 20 Apr 2001 20:30:39 -0400
Date: Fri, 20 Apr 2001 20:30:29 -0400
From: Disconnect <lkml@sigkill.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Athlon problem report summary
Message-ID: <20010420203029.C20176@sigkill.net>
In-Reply-To: <20010420202235.B20176@sigkill.net> <E14qlGJ-0002b8-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14qlGJ-0002b8-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Apr 2001, Alan Cox did have cause to say:

> K7 optimisation basically enabled the MMX copy/clear code which adds 30-40%
> performance to those functions. It also materially ups the maximum memory
> bandwidth the processor will use which may be where the fun starts.

Not to be slow/dull/etc (I -really- appreciate the help here) but possibly
more stupid questions.

Is there anything out there to test/benchmark MMX ops? (Preferably with
reporting on MMX and equiv non-MMX ops, tunable memory bandwidth, etc.)

Also, I can try that same kernel w/ memory set to HCLK (pc100) instead of
HCLK+33 (pc133).  The ram is pc133, but who knows, it might work.  (I'm
pretty sure I had it at pc100 before with no change, but not positive.)

---
-----BEGIN GEEK CODE BLOCK-----
Version: 3.1 [www.ebb.org/ungeek]
GIT/CC/CM/AT d--(-)@ s+:-- a-->? C++++$ ULBS*++++$ P+>+++ L++++>+++++ 
E--- W+++ N+@ o+>$ K? w--->+++++ O- M V-- PS+() PE Y+@ PGP++() t 5--- 
X-- R tv+@ b++++>$ DI++++ D++(+++) G++ e* h(-)* r++ y++
------END GEEK CODE BLOCK------
