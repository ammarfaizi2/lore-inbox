Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288351AbSACW3M>; Thu, 3 Jan 2002 17:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288336AbSACW3H>; Thu, 3 Jan 2002 17:29:07 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:38154 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288351AbSACW13>; Thu, 3 Jan 2002 17:27:29 -0500
Subject: Re: "APIC error on CPUx" - what does this mean?
To: swsnyder@home.com
Date: Thu, 3 Jan 2002 22:38:27 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <20020103195551.BEHH23959.femail47.sdc1.sfba.home.com@there> from "Steve Snyder" at Jan 03, 2002 02:55:50 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16MGVH-0001Jl-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I just noticed the following events in my system log:
> 
>   Jan  3 14:03:39 mercury kernel: APIC error on CPU1: 00(02)
>   Jan  3 14:03:39 mercury kernel: APIC error on CPU0: 00(02)
> 
> Please let me know if I can provide any additional info needed to diagnose 
> this error.

The occasional APIC error is fine (its logging a hardware event - probably
something that caused enough noise to lose a message and retry it). The
APIC bus is designed to stand these occasional errors
