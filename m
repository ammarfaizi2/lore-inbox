Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264299AbUGRRK7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264299AbUGRRK7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 13:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264305AbUGRRK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 13:10:59 -0400
Received: from stokkie.demon.nl ([82.161.49.184]:49796 "HELO stokkie.net")
	by vger.kernel.org with SMTP id S264299AbUGRRK5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 13:10:57 -0400
Date: Sun, 18 Jul 2004 19:10:54 +0200 (CEST)
From: "Robert M. Stockmann" <stock@stokkie.net>
To: linux-kernel@vger.kernel.org
cc: discuss@x86-64.org
Subject: Re: Comparing struct pt_regs : asm-i386 vs asm-x86_64
In-Reply-To: <Pine.LNX.4.44.0407180607320.9290-100000@hubble.stokkie.net>
Message-ID: <Pine.LNX.4.44.0407181906370.19324-100000@hubble.stokkie.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: scanned for viruses by AMaViS 0.2.2 (ftp://crashrecovery.org/pub/linux/amavis/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Jul 2004, Robert M. Stockmann wrote:

> > 
> > So when porting i386 C-code (which uses the struct pt_regs from
> > include/asm-i386/ptrace.h) how does the pt_regs structure translate into
> > the struct pt_regs from include/asm-x86_64/ptrace.h  ?
> > 
> 
> I came across this "Gentle Introduction" on www.x86-64.org :
> 
> "Gentle Introduction to x86-64 Assembly "
> http://www.x86-64.org/documentation/assembly :
> 
> Where the most striking remark is this :
> 
> "This document is meant to summarise differences between x86-64 and i386 
> assembly assuming that you already know well the i386 gas syntax. I will try 
> to keep this document up to date until official documentation is available."
> 
> Amazing stuff! How can one manufacture full-functional x86_64 AMD64 and
> Opteron CPU's in silicon print, while the white-paper print of the "official
> documentation" on assembly programming on x86_64 is NOT available ??
> 

Its seems the docs needed are just for download at http://www.amd.com/ :

http://www.amd.com/us-en/Processors/TechnicalResources/0,,30_182_739_7044,00.html

AMD64 Architecture Programmer's Manual Volume 1: Application Programming
AMD64 Architecture Programmer's Manual Volume 2: System Programming
AMD64 Architecture Programmer's Manual Volume 3: General-Purpose and System Instructions
AMD64 Architecture Programmer's Manual Volume 4: 128-Bit Media Instructions
AMD64 Architecture Programmer's Manual Volume 5: 64-Bit Media and x87 Floating-Point Instructions

Robert
-- 
Robert M. Stockmann - RHCE
Network Engineer - UNIX/Linux Specialist
crashrecovery.org  stock@stokkie.net

