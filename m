Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132326AbRDUAXK>; Fri, 20 Apr 2001 20:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132327AbRDUAXA>; Fri, 20 Apr 2001 20:23:00 -0400
Received: from stanis.onastick.net ([207.96.1.49]:35338 "EHLO
	stanis.onastick.net") by vger.kernel.org with ESMTP
	id <S132326AbRDUAWq>; Fri, 20 Apr 2001 20:22:46 -0400
Date: Fri, 20 Apr 2001 20:22:35 -0400
From: Disconnect <lkml@sigkill.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Athlon problem report summary
Message-ID: <20010420202235.B20176@sigkill.net>
In-Reply-To: <20010420195253.A20176@sigkill.net> <E14ql2L-0002YR-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14ql2L-0002YR-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Apr 2001, Alan Cox did have cause to say:

> > Addendum to 1. So far everyone (at least on LKML) who has had the
> > crash-immediatly-do-not-pass-go issues has been using an iwill kk266 (or
> > kk266r, IIRC) mobo.
> 
> Not quite all. Many have but I have other reports.

Oddness. Is it all on that same via chipset? (I have seen some reports of
the same chipset working on other mobos.)

> As far as I can tell its hardware problems. The fact not a single AMD chipset
> user sees it makes me very suspicious indeed.

Fair enough - I think so as well (although slightly less so since it's
not just the iwill mobo.)

On a (possibly?) unrelated note, memtest-mmx fails immediately (prints the
version, hardlocks).  But I've seen that on a stock PIII as well, so I
don't know what that's worth.  The oops I managed to decode was in
mmx_copy_page.

Is there a way to enable everything-K7-except-MMX? (Or, for that matter,
an easy way to see what K7 does that K6 doesn't.)

---
-----BEGIN GEEK CODE BLOCK-----
Version: 3.1 [www.ebb.org/ungeek]
GIT/CC/CM/AT d--(-)@ s+:-- a-->? C++++$ ULBS*++++$ P+>+++ L++++>+++++ 
E--- W+++ N+@ o+>$ K? w--->+++++ O- M V-- PS+() PE Y+@ PGP++() t 5--- 
X-- R tv+@ b++++>$ DI++++ D++(+++) G++ e* h(-)* r++ y++
------END GEEK CODE BLOCK------
