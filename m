Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266567AbRGGVZ6>; Sat, 7 Jul 2001 17:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266573AbRGGVZs>; Sat, 7 Jul 2001 17:25:48 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:31244 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S266567AbRGGVZf>; Sat, 7 Jul 2001 17:25:35 -0400
Subject: Re: VM in 2.4.7-pre hurts...
To: torvalds@transmeta.com (Linus Torvalds)
Date: Sat, 7 Jul 2001 22:25:32 +0100 (BST)
Cc: jgarzik@mandrakesoft.com (Jeff Garzik),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
        riel@conectiva.com.br (Rik van Riel),
        phillips@bonn-fries.net (Daniel Phillips)
In-Reply-To: <Pine.LNX.4.33.0107071019440.31249-100000@penguin.transmeta.com> from "Linus Torvalds" at Jul 07, 2001 10:28:20 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Iza0-0006GJ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> instead. That way the vmstat output might be more useful, although vmstat
> obviously won't know about the new "SwapCache:" field..
> 
> Can you try that, and see if something else stands out once the misleading
> accounting is taken care of?

Its certainly misleading. I got Jeff to try making oom return 4999 out of 5000
times regardless.
