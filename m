Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268313AbSIRRqq>; Wed, 18 Sep 2002 13:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268330AbSIRRqq>; Wed, 18 Sep 2002 13:46:46 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:46589
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268313AbSIRRqo>; Wed, 18 Sep 2002 13:46:44 -0400
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process()
	elimination, 2.5.35-BK
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ingo Molnar <mingo@elte.hu>, Rik van Riel <riel@conectiva.com.br>,
       Andries Brouwer <aebr@win.tue.nl>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0209181026550.1230-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0209181026550.1230-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 18 Sep 2002 18:54:44 +0100
Message-Id: <1032371684.20402.141.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-09-18 at 18:30, Linus Torvalds wrote:
> 
> On Wed, 18 Sep 2002, Ingo Molnar wrote:
> > 
> > it is a problem still. We can create/destroy 2 billion threads:
> > 
> >    venus:~> ./p3 -s 2000000 -t 10 -r 0 -T --sync-join
> >    Runtime: 19.889182138 seconds
> > 
> > in roughly 5 hours, on bog-standard 2-CPU x86 hardware.
> 
> Again, you're talking about entirely theoretical numbers that have no 
> relevance for real life. 
> 
> Sure, you can do that. But a real life box? Nope.

With a berzerk web script, with a malicious user ?

