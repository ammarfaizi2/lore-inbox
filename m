Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268809AbRG0Jxu>; Fri, 27 Jul 2001 05:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268810AbRG0Jxk>; Fri, 27 Jul 2001 05:53:40 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:62213 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268813AbRG0Jx2>; Fri, 27 Jul 2001 05:53:28 -0400
Subject: Re: 2.4.7 + VIA Pro266 + 2xUltraTx2 lockups
To: rjh@groucho.maths.monash.edu.au (Robin Humble)
Date: Fri, 27 Jul 2001 10:54:47 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "Robin Humble" at Jul 27, 2001 03:26:02 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Q4KV-0005LU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> So the system is stable when driving a single Tx2 card, or on a BX,
> but just not two Tx2's together on the pro266 board :-/ So it's
> perhaps (I'm guessing here :) a non-trivial Tx2 driver bug or maybe a
> VIA Pro266 problem?

Firstly please try 2.4.6-ac5 as that has the proper VIA workaround for their
bridge bugs. Its useful to rule out the very conservative approach the older
kernels use to avoid the disk corruption problem they had

Alan
