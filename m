Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267599AbUHJRbt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267599AbUHJRbt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 13:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267586AbUHJR25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 13:28:57 -0400
Received: from the-village.bc.nu ([81.2.110.252]:35533 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267603AbUHJR23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 13:28:29 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc3-O4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, Florian Schmidt <mista.tapas@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <1092157841.3290.3.camel@mindpipe>
References: <20040726083537.GA24948@elte.hu>
	 <1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu>
	 <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu>
	 <20040801193043.GA20277@elte.hu> <20040809104649.GA13299@elte.hu>
	 <20040809130558.GA17725@elte.hu> <20040809190201.64dab6ea@mango.fruits.de>
	 <1092103522.761.2.camel@mindpipe>  <20040810085849.GC26081@elte.hu>
	 <1092157841.3290.3.camel@mindpipe>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092155147.16979.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 10 Aug 2004 17:25:48 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-08-10 at 18:10, Lee Revell wrote:
> OK, with CONFIG_M586TSC, I am getting a lot of lockups.  A few happened
> during normal desktop use, and it locks up hard when starting jackd. 
> Could this have anything to do with the ALSA drivers (which I am
> compiling seperately from ALSA cvs) detecting my build system as i686? 
> I have read that the C3 is more like a 486 (with MMX & 3DNow) than a
> 686.

The C3 is a full 686 instruction set. The kernel is different because
the GNU tool people couldn't read manuals and once the error was made 
it was a bit too late to fix it.

Thus ALSA deciding its 686 is fine.

