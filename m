Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263137AbSLOWWK>; Sun, 15 Dec 2002 17:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263143AbSLOWWK>; Sun, 15 Dec 2002 17:22:10 -0500
Received: from [195.39.17.254] ([195.39.17.254]:13828 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S263137AbSLOWWI>;
	Sun, 15 Dec 2002 17:22:08 -0500
Date: Sun, 15 Dec 2002 22:59:51 +0100
From: Pavel Machek <pavel@ucw.cz>
To: William Lee Irwin III <wli@holomorphy.com>,
       Mike Hayward <hayward@loup.net>, linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
Message-ID: <20021215215951.GA6347@elf.ucw.cz>
References: <200212090830.gB98USW05593@flux.loup.net> <20021213154544.GK9882@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021213154544.GK9882@holomorphy.com>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Any ideas?  Not sure I want to upgrade to the P7 architecture if this
> > is right, since for me system calls are probably more important than
> > raw cpu computational power.
> 
> This is the same for me. I'm extremely uninterested in the P-IV for my
> own use because of this.

Well, then you should fix the kernel so that syscalls are done by
sysenter (or how is it called).
								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
