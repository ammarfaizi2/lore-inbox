Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265431AbRGGVn2>; Sat, 7 Jul 2001 17:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266582AbRGGVnS>; Sat, 7 Jul 2001 17:43:18 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:44812 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265431AbRGGVnM>; Sat, 7 Jul 2001 17:43:12 -0400
Subject: Re: VM in 2.4.7-pre hurts...
To: riel@conectiva.com.br (Rik van Riel)
Date: Sat, 7 Jul 2001 22:43:06 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds),
        jgarzik@mandrakesoft.com (Jeff Garzik),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
        phillips@bonn-fries.net (Daniel Phillips)
In-Reply-To: <Pine.LNX.4.33L.0107071828500.1389-100000@duckman.distro.conectiva> from "Rik van Riel" at Jul 07, 2001 06:29:30 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Izr0-0006Hy-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Its certainly misleading. I got Jeff to try making oom return
> > 4999 out of 5000 times regardless.
> 
> In that case, he _is_ OOM.  ;)

Hardly

> 1) (almost) no free memory
> 2) no free swap
> 3) very little pagecache + buffer cache

Large amounts of cache, which went away when the OOM code was neutered

