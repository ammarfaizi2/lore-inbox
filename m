Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287373AbSALT5x>; Sat, 12 Jan 2002 14:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287381AbSALT5n>; Sat, 12 Jan 2002 14:57:43 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:21265 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287373AbSALT5c>; Sat, 12 Jan 2002 14:57:32 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
To: ed.sweetman@wmich.edu (Ed Sweetman)
Date: Sat, 12 Jan 2002 20:09:08 +0000 (GMT)
Cc: arjan@fenrus.demon.nl, alan@lxorguk.ukuu.org.uk (Alan Cox),
        landley@trommello.org (Rob Landley), linux-kernel@vger.kernel.org
In-Reply-To: <005b01c19b9e$90a5af40$0501a8c0@psuedogod> from "Ed Sweetman" at Jan 12, 2002 02:23:00 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16PUSi-00032N-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> hardware to hardware could have a higher priority than normal programs being
> run.   That way they're not preempted by simple programs, it would have to
> be purposely preempted by the user.

How do you know they are there. How do you detect the situation, or do you
plan to audit every driver ?

> Lowering the latency, sure the low latency code probably does nearly as well
> as the preempt patch.  that's fine.  Shortening the time locks are held by

Not nearly as well. The tests I've seen it runs _better_ than just pre-empt
and pre-empt + low latency is the same as pure low latency - 1mS

Alan
