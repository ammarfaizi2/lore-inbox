Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315806AbSG3Roh>; Tue, 30 Jul 2002 13:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315856AbSG3Roh>; Tue, 30 Jul 2002 13:44:37 -0400
Received: from [195.39.17.254] ([195.39.17.254]:1408 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S315806AbSG3Rof>;
	Tue, 30 Jul 2002 13:44:35 -0400
Date: Tue, 30 Jul 2002 00:20:52 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Robert Love <rml@tech9.net>, akpm@zip.com.au, riel@conectiva.com.br,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] 2.5-rmap: VM strict overcommit
Message-ID: <20020729222052.GA15219@elf.ucw.cz>
References: <1026928763.1116.11.camel@sinai> <20020726103104.GA279@elf.ucw.cz> <1027694803.13428.43.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1027694803.13428.43.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > In what scenario can "strict overcommit" kill?
> 
> When the kernel grabs over 50% of RAM. Remember that includes page
> tables. I've seen the kernel taking 35% of RAM.

But it could happen that kernel would attempt to allocate 101% of RAM
for page tables, right? At that even "paranoid overcommit" might be
OOM, right?
								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
