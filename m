Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286996AbSABUlg>; Wed, 2 Jan 2002 15:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287955AbSABUl0>; Wed, 2 Jan 2002 15:41:26 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:30221 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287953AbSABUju>; Wed, 2 Jan 2002 15:39:50 -0500
Subject: Re: Linux 2.4.17 vs 2.2.19 vs rml new VM
To: jjs@lexus.com (J Sloan)
Date: Wed, 2 Jan 2002 20:50:02 +0000 (GMT)
Cc: brian@worldcontrol.com, linux-kernel@vger.kernel.org
In-Reply-To: <3C335A77.806@lexus.com> from "J Sloan" at Jan 02, 2002 11:07:35 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16LsKp-0005Ox-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I find the low latency patch makes a noticeable
> difference in e.g. q3a and rtcw - OTOH I have
> not been able to discern any tangible difference
> from the stock kernel when using -preempt.

The measurements I've seen put lowlatency ahead of pre-empt in quality
of results. Since low latency fixes some of the locked latencies it might
be interesting for someone with time to benchmark

	vanilla
	low latency
	pre-empt
	both together
