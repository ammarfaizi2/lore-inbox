Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270132AbRHMMOf>; Mon, 13 Aug 2001 08:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270130AbRHMMOZ>; Mon, 13 Aug 2001 08:14:25 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:18436 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270131AbRHMMOU>; Mon, 13 Aug 2001 08:14:20 -0400
Subject: Re: Hang problem on Tyan K7 Thunder resolved -- SB Live! heads-up
To: torvalds@transmeta.com (Linus Torvalds)
Date: Mon, 13 Aug 2001 13:16:16 +0100 (BST)
Cc: pgallen@randomlogic.com, linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "Linus Torvalds" at Aug 12, 2001 06:00:34 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15WGdk-0007H8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does the new driver not work for you? There seems to be a bug at close()
> time, in that the driver uses "tasklet_unlock_wait()" instead of
> "tasklet_kill()" to kill the tasklets, and that wouldn't work reliably.

It hung my SMP box solid
It spews white noise on my box with surround speakers
And worked on the third

So I went back to the old one.

Alan
