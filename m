Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284753AbRLRTCE>; Tue, 18 Dec 2001 14:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284744AbRLRTAq>; Tue, 18 Dec 2001 14:00:46 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:31760 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284604AbRLRTAC>; Tue, 18 Dec 2001 14:00:02 -0500
Subject: Re: Turning off nagle algorithm in 2.2.x and 2.4.x kernels?
To: Zameer.Ahmed@gs.com (Ahmed, Zameer)
Date: Tue, 18 Dec 2001 19:10:02 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk ('Alan Cox'), Zameer.Ahmed@gs.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <FBC7494738B7D411BD7F00902798761908BFF19B@gsny49e.ny.fw.gs.com> from "Ahmed, Zameer" at Dec 18, 2001 12:05:33 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16GPco-0008MR-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The finicky nature of closed sourced sybase libraries that we are using in
> the custom apps make me ask this question. Will turning off the Nagle
> algorithm in the kernel on the fly, impact performance in any way? or Can we
> have this feature in the kernel in some way?

Turning it off generically risks extremely bad network behaviour on a 
congested link. 
