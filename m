Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279472AbRJ2Udw>; Mon, 29 Oct 2001 15:33:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279473AbRJ2Udm>; Mon, 29 Oct 2001 15:33:42 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:63241 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S279472AbRJ2Ud1>; Mon, 29 Oct 2001 15:33:27 -0500
Subject: Re: Nasty suprise with uptime
To: jjs@lexus.com (J Sloan)
Date: Mon, 29 Oct 2001 20:40:35 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux kernel)
In-Reply-To: <3BDDBC90.7E16E492@lexus.com> from "J Sloan" at Oct 29, 2001 12:31:12 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15yJD1-0003uO-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> and received a nasty surprise. The uptime, which had been 496+ days
> on Friday, was back down to a few hours. I was ready to lart somebody
> with great vigor when I realized the uptime counter had simply wrapped
> around.
> 
> So, I thought to myself, at least the 2.4 kernels on our new boxes won't

It wraps at 496 days. The drivers are aware of it and dont crash the box

Alan
