Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268512AbTB1X45>; Fri, 28 Feb 2003 18:56:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268492AbTB1X45>; Fri, 28 Feb 2003 18:56:57 -0500
Received: from wildsau.idv.uni.linz.at ([213.157.128.253]:4494 "EHLO
	wildsau.idv.uni.linz.at") by vger.kernel.org with ESMTP
	id <S268512AbTB1X4z>; Fri, 28 Feb 2003 18:56:55 -0500
Message-Id: <200303010005.h2105dls031131@wildsau.idv.uni.linz.at>
Subject: Re: emm386 hangs when booting from linux
In-Reply-To: <3E5FF7E4.FB290D8F@daimi.au.dk> from Kasper Dupont at "Mar 1, 3 00:59:32 am"
To: kasperd@daimi.au.dk (Kasper Dupont)
Date: Sat, 1 Mar 2003 01:05:39 +0100 (MET)
Cc: kernel@wildsau.idv.uni.linz.at, root@chaos.analogic.com,
       linux-kernel@vger.kernel.org, herp@wildsau.idv.uni.linz.at
From: hr@gup.uni-linz.ac.at
X-Mailer: ELM [version 2.4ME+ PL37 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > On the other hand, when instead of loadling MBR and executing it, I
> > do a far jmp to 0xf000:0xfff0 from "machine_real_start",
> 
> Isn't that code conventionally called by jumping to
> 0xffff:0x0000? (Not that it matters, because the first
> instruction in all BIOSes I have seen is a jump to
> 0xf000:0xe05b.)

my processor book says that a RESET sets cs to f000 and ip to fff0,
so I used the same values.
 

