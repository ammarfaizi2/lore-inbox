Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287560AbSAEG6u>; Sat, 5 Jan 2002 01:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287568AbSAEG6b>; Sat, 5 Jan 2002 01:58:31 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:1286 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S287565AbSAEG60>; Sat, 5 Jan 2002 01:58:26 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: ISA slot detection on PCI systems?
Date: 4 Jan 2002 22:58:09 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a16861$p88$1@cesium.transmeta.com>
In-Reply-To: <20020102170833.A17655@thyrsus.com> <E16Lu2i-0005nd-00@the-village.bc.nu> <20020102172448.A18153@thyrsus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20020102172448.A18153@thyrsus.com>
By author:    "Eric S. Raymond" <esr@thyrsus.com>
In newsgroup: linux.dev.kernel
> 
> But you're thinking like a developer, not a user.  The right question
> is which approach requires the lowest level of *user* privilege to get
> the job done.  Comparing world-readable /proc files versus a setuid app,
> the answer is obvious.  This sort of thing is exactly what /proc is *for*.
> 

BULLSHIT.  The user privilege level is identical in either case (no
special privilege needed.)

The setuid app is a lower privilege level than the kernel code you're
proposing adding.  Not just is it bloat, it's actually a deterioration
in the overall security of the system.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
