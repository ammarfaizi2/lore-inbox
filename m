Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282992AbRLDJUZ>; Tue, 4 Dec 2001 04:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282983AbRLDJUP>; Tue, 4 Dec 2001 04:20:15 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:38416 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S282940AbRLDJT6>; Tue, 4 Dec 2001 04:19:58 -0500
Subject: Re: Linux/Pro [was Re: Coding style - a non-issue]
To: znmeb@aracnet.com (M. Edward Borasky)
Date: Tue, 4 Dec 2001 09:28:49 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <HBEHIIBBKKNOBLMPKCBBEENCECAA.znmeb@aracnet.com> from "M. Edward Borasky" at Dec 03, 2001 06:31:38 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16BBsg-0001Ny-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What I'm trying to establish here is that if ALSA is to become the
> main-stream Linux sound driver set, it's going to need to support -- *fully*
> support -- the top-of-the-line sound cards like my M-Audio Delta 66. It

Not really. The number of people who actually care about such cards is close
to nil. What matters is that the API can cleanly express what the Delta66
can do, and that you can write a driver for it under ALSA without hacking up
the ALSA core.

I'm happy both of those are true.
