Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284927AbRLZUv0>; Wed, 26 Dec 2001 15:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284924AbRLZUvR>; Wed, 26 Dec 2001 15:51:17 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:61452 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284899AbRLZUu7>; Wed, 26 Dec 2001 15:50:59 -0500
Subject: Re: Unusual Stacksize Question
To: calin@ajvar.org (Calin A. Culianu)
Date: Wed, 26 Dec 2001 21:01:17 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0112261534370.21850-100000@rtlab.med.cornell.edu> from "Calin A. Culianu" at Dec 26, 2001 03:46:05 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16JLAs-00035Q-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> coredump.  I used setrlimit() to set the stacksize limit to infinity.  No
> more core dumps.  But guess what?  Like half the time I now get a kernel
> panic screen dump and the system immediately hangs...  I should think that
> really, as long as you have enough memory, both real and imagined (I made
> that term up too), nothing too bad can happen beyond a coredump maybe.

Core dumps if you have it too large I can believe. A kernel panic is
somewhat more worrying, but some bugs in exec validation did get fixed.
If you can make the 7.1 errata kernel oops as well I'm very interested
indeed.

