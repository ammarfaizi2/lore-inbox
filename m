Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265402AbRFYHHO>; Mon, 25 Jun 2001 03:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265405AbRFYHHE>; Mon, 25 Jun 2001 03:07:04 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:29707 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265402AbRFYHG4>; Mon, 25 Jun 2001 03:06:56 -0400
Subject: Re: VIA Southbridge bug (Was: Crash on boot (2.4.5))
To: srwalter@yahoo.com (Steven Walter)
Date: Mon, 25 Jun 2001 08:06:30 +0100 (BST)
Cc: andyw@edafio.com (Andy Ward), linux-kernel@vger.kernel.org
In-Reply-To: <20010625013241.A23425@hapablap.dyn.dhs.org> from "Steven Walter" at Jun 25, 2001 01:32:41 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15EQS6-0001Ft-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Great, glad to here it.  Who (if anyone) is still attempting to unravel
> the puzzle of the Via southbridge bug?  You, Andy, should try and get in
> touch with them and help debug this thing, if you're up to it.

The IWILL problem seems unrelated. Its the board that more than others people
report fails totally when streaming memory copies using movntq instructions.

The Athlon optimised kernel places pretty much the absolute maximum load 
possible on the memory bus. Several people have reported that machines that
are otherwise stable on the bios fast options require  the proper conservative
settings to be stable with the Athlon optimisations

Alan

