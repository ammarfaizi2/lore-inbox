Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317920AbSFNOkz>; Fri, 14 Jun 2002 10:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317923AbSFNOky>; Fri, 14 Jun 2002 10:40:54 -0400
Received: from mauve.demon.co.uk ([158.152.209.66]:962 "EHLO mauve.demon.co.uk")
	by vger.kernel.org with ESMTP id <S317920AbSFNOkx>;
	Fri, 14 Jun 2002 10:40:53 -0400
From: Ian Stirling <root@mauve.demon.co.uk>
Message-Id: <200206141440.PAA11680@mauve.demon.co.uk>
Subject: Re: Accessing odd bytes
To: robert@schwebel.de (Robert Schwebel)
Date: Fri, 14 Jun 2002 15:40:37 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020614143140.A7467@schwebel.de> from "Robert Schwebel" at Jun 14, 2002 02:31:40 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> I have a strange effect on an embedded system (AMD Elan SC410,
> Linux-2.4.18) while accessing a static RAM.  The RAM is mapped to the bus
> at 0x0200'0000. If I map it to user space this way: 
<snip>
> Now I'm wondering how the kernel/processor handles odd byte access
> exceptions. Can anybody give me a pointer where I could search or what my
> problem could be? 

It has been a while, but I believe you may need to setup the SC410s MMU
to tell it it's an 8 bit (or whateve) RAM.
Reading the manuals may reveal details that I've forgotten.
