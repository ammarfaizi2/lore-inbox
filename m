Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132316AbRDJPnv>; Tue, 10 Apr 2001 11:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132313AbRDJPnb>; Tue, 10 Apr 2001 11:43:31 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:14854 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132301AbRDJPn3>; Tue, 10 Apr 2001 11:43:29 -0400
Subject: Re: No 100 HZ timer !
To: mikulas@artax.karlin.mff.cuni.cz
Date: Tue, 10 Apr 2001 16:43:47 +0100 (BST)
Cc: ds@schleef.org (David Schleef), alan@lxorguk.ukuu.org.uk (Alan Cox),
        mbs@mc.com (Mark Salisbury), jdike@karaya.com (Jeff Dike),
        schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.96.1010410155723.28395A-100000@artax.karlin.mff.cuni.cz> from "Mikulas Patocka" at Apr 10, 2001 04:10:28 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14n0J3-0004U6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Timers more precise than 100HZ aren't probably needed - as MIN_RTO is 0.2s
> and MIN_DELACK is 0.04s, TCP would hardly benefit from them.

There are a considerable number of people who really do need 1Khz resolution.
Midi is one of the example cases. That doesn't mean we have to go to a 1KHz
timer, we may want to combine a 100Hz timer with a smart switch to 1Khz

