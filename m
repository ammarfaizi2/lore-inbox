Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136111AbREGOA5>; Mon, 7 May 2001 10:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136114AbREGOAr>; Mon, 7 May 2001 10:00:47 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:55560 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136111AbREGOAf>; Mon, 7 May 2001 10:00:35 -0400
Subject: Re: what causes Machine Check exception? revisited (2.2.18)
To: Martin.Bene@KPNQwest.com (Bene, Martin)
Date: Mon, 7 May 2001 14:51:01 +0100 (BST)
Cc: Simon.Richter@phobos.fachschaften.tu-muenchen.de ('Simon Richter'),
        linux-kernel@vger.kernel.org ('linux-kernel@vger.kernel.org')
In-Reply-To: <5F6171E541C8D311B9F200508B63D32801C31F52@ntexgvie01> from "Bene, Martin" at May 07, 2001 03:33:54 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14wlPj-0003WB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You get SIG11 errors when running programs(kernel compile seems to be agood
> example), you get crashing processes, you get all sorts of weird funnies but
> you really shouldn't get machine check exceptions.
> 
> I don't think there is a way a machine check exception can be triggered by
> software - which it would have to be in order to be caused by bad RAMs.

Bad ECC memory and unrecoverable ECC faults can certainly be reported back to
the processor electrically. Also an L2 cache load failing when the RAM fails
to ack the signals is quite visible to a processor.

