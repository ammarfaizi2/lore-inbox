Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422833AbWJFSea@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422833AbWJFSea (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 14:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422832AbWJFSea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 14:34:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24479 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422831AbWJFSe1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 14:34:27 -0400
Date: Fri, 6 Oct 2006 11:34:16 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Ben Dooks <ben-linux@fluff.org>
cc: Deepak Saxena <dsaxena@plexity.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19-git] Fix ARM breakage due to no irq_regs.h
In-Reply-To: <20061006182228.GA19320@home.fluff.org>
Message-ID: <Pine.LNX.4.64.0610061131160.3952@g5.osdl.org>
References: <20061006180755.GA31679@plexity.net> <Pine.LNX.4.64.0610061112220.3952@g5.osdl.org>
 <20061006182228.GA19320@home.fluff.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 6 Oct 2006, Ben Dooks wrote:
> 
> It should get built ky Kautobuild when the next -git is
> released (http://armlinux.simtec.co.uk/kautobuild/) which
> should at least tell us if it builds.

Sure, but havign a 24-hour latency between test-builds is not exactly a 
great way to do this ;)

For example, the one-liner that Deepak sent in will certainly fix the 
particular build error that the autobuild site has right now. But doing it 
one error at a time would be somewhat less than productive, considering 
that the patch I committed was 2695 lines ;)

Of course, assuming I did actually get most of them (and that I didn't 
introduce any stupid new syntax errors), the next autobuild report may be 
more useful. Still, I know several people have arm build environments 
already set up, so..

		Linus
