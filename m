Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268140AbTCFRe0>; Thu, 6 Mar 2003 12:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268156AbTCFRe0>; Thu, 6 Mar 2003 12:34:26 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:16807
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268140AbTCFReY>; Thu, 6 Mar 2003 12:34:24 -0500
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@digeo.com>, rml@tech9.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0303061801250.13726-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0303061801250.13726-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046976597.17715.93.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 06 Mar 2003 18:49:57 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-06 at 17:11, Ingo Molnar wrote:
> X is special. Especially in Andrew's wild-window-dragging experiment X is
> a pure CPU-bound task that just eats CPU cycles no end. There _only_ thing
> that makes it special is that there's a human looking at the output of the
> X client. This is information that is simply not available to the kernel.

Just like a streaming video server
Just like a 3D game using DRI

X isnt special at all. Research OS people have done stuff like time transfers
but I've not seen that in a production OS. In that situation an interactive
task blocking on a server hands on some of its interactiveness to whoever
services the request.

Thats not a trivial Linux addition however

