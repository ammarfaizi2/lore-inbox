Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280713AbRKGAXp>; Tue, 6 Nov 2001 19:23:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280709AbRKGAX3>; Tue, 6 Nov 2001 19:23:29 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:47375 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280713AbRKGAWQ>; Tue, 6 Nov 2001 19:22:16 -0500
Subject: Re: Linux kernel 2.4 and TCP terminations per second.
To: david.lang@digitalinsight.com (David Lang)
Date: Wed, 7 Nov 2001 00:29:23 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), imran.badr@cavium.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.40.0111061555210.24952-100000@dlang.diginsite.com> from "David Lang" at Nov 06, 2001 03:56:55 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E161Gap-0002MD-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> from a recent test I just was running with apache on a 1.2GHZ athlon 512MB
> ram it looks like it will do ~1800 connections/sec.
> 
> just to put the numbers below in perspective :-)

I was doing 2000 a second on a P2/233 just to keep the perspective. I've
not yet hacked thttpd to try Linus new readahead syscall
