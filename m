Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261531AbVEaVWl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261531AbVEaVWl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 17:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261532AbVEaVWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 17:22:41 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:42699 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S261531AbVEaVWg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 17:22:36 -0400
Subject: Re: Machine Freezes while Running Crossover Office
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, Pekka Enberg <penberg@gmail.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050531184101.GA3175@elte.hu>
References: <84144f0205052911202863ecd5@mail.gmail.com>
	 <Pine.LNX.4.58.0505291143350.10545@ppc970.osdl.org>
	 <1117399764.9619.12.camel@localhost>
	 <Pine.LNX.4.58.0505291543070.10545@ppc970.osdl.org>
	 <1117466611.9323.6.camel@localhost>
	 <Pine.LNX.4.58.0505301024080.10545@ppc970.osdl.org>
	 <courier.429C05C1.00005CC5@courier.cs.helsinki.fi>
	 <20050531065456.GA21948@elte.hu> <1117558435.9228.7.camel@localhost>
	 <Pine.LNX.4.58.0505311010410.1876@ppc970.osdl.org>
	 <20050531184101.GA3175@elte.hu>
Date: Wed, 01 Jun 2005 00:20:06 +0300
Message-Id: <1117574407.9231.3.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-31 at 20:41 +0200, Ingo Molnar wrote:
> Now, assuming you can confirm that doing:
> 
>   echo 5 > /proc/sys/kernel/INTERACTIVE_DELTA

The hang goes away with a magic number of 6 (although it does not seem
as smooth as with turning off interactivity completely). With 5, I still
get the hang but it is noticeable shorter than before. Number 4 gives me
the same old hang.

Ingo, are there other patches you wanted me to try out?

			Pekka

