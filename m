Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282843AbSANOXr>; Mon, 14 Jan 2002 09:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283204AbSANOXg>; Mon, 14 Jan 2002 09:23:36 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:1811 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S282843AbSANOXR>; Mon, 14 Jan 2002 09:23:17 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
To: zippel@linux-m68k.org (Roman Zippel)
Date: Mon, 14 Jan 2002 14:35:00 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), yodaiken@fsmlabs.com,
        phillips@bonn-fries.net (Daniel Phillips),
        arjan@fenrus.demon.nl (Arjan van de Ven), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0201141330350.29208-100000@serv> from "Roman Zippel" at Jan 14, 2002 02:39:45 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Q8CS-0001rO-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So the worst behaviour I see is that on a loaded system, a low priority
> task can hold up another task, if that task should be our interactive
> task, the interactivity is of course gone. But this problem is not really
> new, as we have no guarantees regarding i/o latencies. So everyone using
> any patch should be aware of that it's not a magical tool and for getting
> better scheduling latencies, one has to trade something else, but so far
> I haven't seen any evidence that it makes something else much worse.

It doesn't make anything better is the issue. Its more complex than ll but
gains nothing
