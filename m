Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289931AbSAKM0L>; Fri, 11 Jan 2002 07:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289932AbSAKM0B>; Fri, 11 Jan 2002 07:26:01 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:5636 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289931AbSAKMZx>; Fri, 11 Jan 2002 07:25:53 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
To: nigel@nrg.org
Date: Fri, 11 Jan 2002 12:37:09 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), landley@trommello.org (Rob Landley),
        akpm@zip.com.au (Andrew Morton), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.40.0201101840470.5213-100000@cosmic.nrg.org> from "Nigel Gamble" at Jan 10, 2002 06:47:45 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16P0vl-0007Tu-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On good hardware, we can easily do much better than 1ms latency with a
> preemptible kernel and a spinlock cleanup.  I don't think the
> limitations of some PC hardware should limit our goals for Linux.

Its more than a spinlock cleanup at that point. To do anything useful you have
to tackle both priority inversion and some kind of at least semi-formal 
validation of the code itself. At the point it comes down to validating the
code I'd much rather validate rtlinux than the entire kernel

Alan
