Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282878AbRLQVDo>; Mon, 17 Dec 2001 16:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282880AbRLQVDf>; Mon, 17 Dec 2001 16:03:35 -0500
Received: from insws8502.gs.com ([204.4.182.11]:32934 "HELO insws8502.gs.com")
	by vger.kernel.org with SMTP id <S282878AbRLQVD2>;
	Mon, 17 Dec 2001 16:03:28 -0500
Message-Id: <FBC7494738B7D411BD7F00902798761908BFF190@gsny49e.ny.fw.gs.com>
From: "Ahmed, Zameer" <Zameer.Ahmed@gs.com>
To: linux-kernel@vger.kernel.org
Subject: Turning off nagle algorithm in 2.2.x and 2.4.x kernels?
Date: Mon, 17 Dec 2001 16:03:15 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	Is there a way to turn off nagle compression in the kernel for 2.2.x
and 2.4.x kernels? For the same custom app used under Solaris and Linux.
Turning off nagle algorithm boosted perf on Solaris, I tried commenting out

#bool 'IP: Disable NAGLE algorithm (normally enabled)' CONFIG_TCP_NAGLE_OF

from the net/ipv4/Config.in 2.2.19 kernel and still the degradation in
network performance for packts in midsize persists
I tried the 2.4.16 kernel. This gave me very slight improvement, but not
quite what is expected.

TIA
Zameer A.
