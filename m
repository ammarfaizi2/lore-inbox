Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267604AbUHEIek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267604AbUHEIek (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 04:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267608AbUHEIek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 04:34:40 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:49931 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S267604AbUHEIeh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 04:34:37 -0400
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: gene.heskett@verizon.net, linux-kernel@vger.kernel.org
Subject: Re: Possible dcache BUG
Date: Thu, 5 Aug 2004 11:33:44 +0300
X-Mailer: KMail [version 1.4]
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <20040804204640.64cd65fc.akpm@osdl.org> <200408050031.21366.gene.heskett@verizon.net>
In-Reply-To: <200408050031.21366.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200408051133.44684.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, it has, in the past week, ran memtest86-3a for 12 full passes
> over the whole gig of ram with no errors.  This was the longest test,
> I gave it a 2 hour, 5 pass test before I ever booted linux the first
> time on this motherboard over 2 weeks ago now, a new Biostar
> M7NCD-Pro, with an nforce2(3?) chipset.  I did that because I was
> comeing from an older board whose memory had been overstressed by a
> failing video card and I wanted to make sure this new memory, nearly
> $210 worth of it, was good. I gave it another, probably 4 hour test
> after the first couple of crashes, which it also passed.  And it got

You may use cpuburn to test RAM/CPU too.

Although I have a memory which, when clocked a bit too high,
pass both memtest86 and cpuburn for extended periods of time,
yet large compile runs die with sig11 sometimes. Using a tiny
bit less aggressive clocking helped. :)
-- 
vda
