Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284280AbRLRRGA>; Tue, 18 Dec 2001 12:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284283AbRLRRFu>; Tue, 18 Dec 2001 12:05:50 -0500
Received: from insws8502.gs.com ([204.4.182.11]:27009 "HELO insws8502.gs.com")
	by vger.kernel.org with SMTP id <S284280AbRLRRFi>;
	Tue, 18 Dec 2001 12:05:38 -0500
Message-Id: <FBC7494738B7D411BD7F00902798761908BFF19B@gsny49e.ny.fw.gs.com>
From: "Ahmed, Zameer" <Zameer.Ahmed@gs.com>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>, Zameer.Ahmed@gs.com
Cc: linux-kernel@vger.kernel.org
Subject: RE: Turning off nagle algorithm in 2.2.x and 2.4.x kernels?
Date: Tue, 18 Dec 2001 12:05:33 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The finicky nature of closed sourced sybase libraries that we are using in
the custom apps make me ask this question. Will turning off the Nagle
algorithm in the kernel on the fly, impact performance in any way? or Can we
have this feature in the kernel in some way?

TIA
Zameer A.


-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
Sent: Tuesday, December 18, 2001 9:58 AM
To: Zameer.Ahmed@gs.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Turning off nagle algorithm in 2.2.x and 2.4.x kernels?


> and 2.4.x kernels? For the same custom app used under Solaris and Linux.
> Turning off nagle algorithm boosted perf on Solaris, I tried commenting
out

man setsockopt (Linux and Solaris)

