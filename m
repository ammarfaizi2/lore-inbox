Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284736AbRLUQkJ>; Fri, 21 Dec 2001 11:40:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284732AbRLUQkA>; Fri, 21 Dec 2001 11:40:00 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:2579 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284736AbRLUQjz>; Fri, 21 Dec 2001 11:39:55 -0500
Subject: Re: Slight optimizations to entry.S patch
To: akhripin@mit.edu (Alex)
Date: Fri, 21 Dec 2001 16:49:54 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011220223221.GA17913@morgoth.mit.edu> from "Alex" at Dec 20, 2001 05:32:21 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16HSrq-0000lT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I was familiarizing (or trying to) myself with the i386 architecture code,
> and saw a few possible optimizations. I think they can save a few cycles (not
> that many). Can someone comment? Are the changes worthwhile?

Measure them and see - look at the rdtsc instruction, run a million
iterations of all the various variants and see what you find
