Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271399AbRHOUJr>; Wed, 15 Aug 2001 16:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271398AbRHOUJh>; Wed, 15 Aug 2001 16:09:37 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:61453 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271399AbRHOUJY>; Wed, 15 Aug 2001 16:09:24 -0400
Subject: Re: Problems with sound in 2.4.x (.7 and .8 definitely) with CS4248
To: vichu@digitalme.com (Trever Adams)
Date: Wed, 15 Aug 2001 21:11:55 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010815193502Z271373-760+2100@vger.kernel.org> from "Trever Adams" at Aug 15, 2001 07:24:51 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15X719-0003ua-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Whether it be MP3, OGG, or whatever, I cannot play sound
> without getting the following message in 2.4.7 and 2.4.8 (I
> don't believe I tried any other versions).  However, I
> believe it works (unless hardware failure has happened in
> the past 6 mos) in 2.2.x.
> 
> Sound: DMA (output) timed out - IRQ/DRQ config error?

This message occurs when the audio doesn't generate an interrupt for
the completion of a block of sound. It might for example indicate that the
irq setting passed when you configured it was wrong.

Alan
