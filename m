Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281059AbRLBQgd>; Sun, 2 Dec 2001 11:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282895AbRLBQgV>; Sun, 2 Dec 2001 11:36:21 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:26641 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S282894AbRLBQgO>; Sun, 2 Dec 2001 11:36:14 -0500
Subject: Re: Linux/Pro [was Re: Coding style - a non-issue]
To: dalecki@evision.ag
Date: Sun, 2 Dec 2001 16:42:59 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), lm@bitmover.com (Larry McVoy),
        davidel@xmailserver.org (Davide Libenzi),
        akpm@zip.com.au (Andrew Morton),
        phillips@bonn-fries.net (Daniel Phillips),
        hps@intermeta.de (Henning Schmiedehausen),
        jgarzik@mandrakesoft.com (Jeff Garzik), linux-kernel@vger.kernel.org
In-Reply-To: <3C0A54F4.C70C815C@evision-ventures.com> from "Martin Dalecki" at Dec 02, 2001 05:21:08 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16AZhj-0003pe-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Question: What happens when people stick 8 threads of execution on a die with
> > a single L2 cache ?
> 
> That had been already researched. Gogin bejoind 2 threads on a single
> CPU
> engine doesn't give you very much... The first step is giving about 25%
> the second only about 5%. There are papers in the IBM research magazine
> on

The IBM papers make certain architectural assumptions. With some of the
tiny modern CPU cores its going to perfectly viable to put 4 or 8 of them
on one die. At that point cccluster still has to have cluster nodes scaling
to 8 way

