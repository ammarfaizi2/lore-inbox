Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132967AbRDESjH>; Thu, 5 Apr 2001 14:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132968AbRDESi5>; Thu, 5 Apr 2001 14:38:57 -0400
Received: from mx1out.umbc.edu ([130.85.253.51]:23010 "EHLO mx1out.umbc.edu")
	by vger.kernel.org with ESMTP id <S132967AbRDESio>;
	Thu, 5 Apr 2001 14:38:44 -0400
Date: Thu, 5 Apr 2001 14:38:01 -0400
From: John Jasen <jjasen1@umbc.edu>
X-X-Sender: <jjasen1@irix2.gl.umbc.edu>
To: <linux-kernel@vger.kernel.org>
Subject: Re: kernel bug in 2.4.2-ac28, patched with 6.1.8 aic drivers
In-Reply-To: <Pine.SGI.4.31L.02.0104051048001.2606646-100000@irix2.gl.umbc.edu>
Message-ID: <Pine.SGI.4.31L.02.0104051434310.2685781-100000@irix2.gl.umbc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Apr 2001, John Jasen wrote:

> got this on booting up 2.4.2-ac28:
> Apr  5 09:36:37 grim kernel: kernel BUG at slab.c:1244!
> Apr  5 09:36:37 grim kernel: invalid operand: 0000

errr ... belay that one.

a) I said I didn't get it in 2.4.3-ac3, which was only about 30% correct.
(I've gotten it 7 out of 9 times, since then).

and

b) it occured on a 2.4.2-ac28 tree without the aic7xxx driver update
(which shouldn'tve mattered anyway, in theory)

and

c) It happened right after webmin (don't ask!) started, and just for
giggles, I shut off webmin, rebooted, and -- no more problem.

*shrug*

--
-- John E. Jasen (jjasen1@umbc.edu)
-- In theory, theory and practise are the same. In practise, they aren't.

