Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268589AbRGYQio>; Wed, 25 Jul 2001 12:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268586AbRGYQhE>; Wed, 25 Jul 2001 12:37:04 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:54802 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S268588AbRGYQg4>;
	Wed, 25 Jul 2001 12:36:56 -0400
Message-Id: <200107242231.CAA00481@mops.inr.ac.ru>
Subject: Re: Patch suggestion for proxy arp on shaper interface
To: berto@fatamorgana.COM (Roberto Arcomano)
Date: Wed, 25 Jul 2001 02:31:15 +0400 (MSD)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01072222314006.01071@berto.casa.it> from "Roberto Arcomano" at Jul 23, 1 00:45:01 am
From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello!

> Recently I have had a problem with Linux proxy arp feature (using with shaper

You must not enable proxy arp, when routing is asymmetric or configure
it manually. Shaper device is one of cases, when proxy arp cannot work
correctly.

Alexey
