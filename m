Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131819AbRAaAxe>; Tue, 30 Jan 2001 19:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131858AbRAaAxY>; Tue, 30 Jan 2001 19:53:24 -0500
Received: from mx1out.umbc.edu ([130.85.253.51]:18819 "EHLO mx1out.umbc.edu")
	by vger.kernel.org with ESMTP id <S131819AbRAaAxO>;
	Tue, 30 Jan 2001 19:53:14 -0500
Date: Tue, 30 Jan 2001 19:53:11 -0500
From: John Jasen <jjasen1@umbc.edu>
X-X-Sender: <jjasen1@irix2.gl.umbc.edu>
To: Matthew Gabeler-Lee <msg2@po.cwru.edu>
cc: <linux-kernel@vger.kernel.org>, AmNet Computers <amnet@amnet-comp.com>
Subject: Re: bttv problems in 2.4.0/2.4.1
In-Reply-To: <Pine.LNX.4.32.0101301830330.1138-100000@cheetah.STUDENT.cwru.edu>
Message-ID: <Pine.SGI.4.31L.02.0101301951040.887333-100000@irix2.gl.umbc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jan 2001, Matthew Gabeler-Lee wrote:

> These errors all occur in the same way (as near as I can tell) in
> kernels 2.4.0 and 2.4.1, using bttv drivers 0.7.50 (incl. w/ kernel),
> 0.7.53, and 0.7.55.
>
> I am currently using 2.4.0-test10 with bttv 0.7.47, which works fine.
>
> I have sent all this info to Gerd Knorr but, as far as I know, he hasn't
> been able to track down the bug yet.  I thought that by posting here,
> more eyes might at least make more reports of similar situations that
> might help track down the problem.

Try flipping the card into a different slot. A lot of the cards
exceptionally do not like IRQ/DMA sharing, and a lot of the motherboards
share them between different slots.

--
-- John E. Jasen (jjasen1@umbc.edu)
-- In theory, theory and practise are the same. In practise, they aren't.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
