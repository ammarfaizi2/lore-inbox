Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261338AbSIZQh6>; Thu, 26 Sep 2002 12:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261344AbSIZQh6>; Thu, 26 Sep 2002 12:37:58 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:7930 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261338AbSIZQh5>; Thu, 26 Sep 2002 12:37:57 -0400
Subject: Re: [patch] 'sticky pages' support in the VM, futex-2.5.38-C5
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@zip.com.au>
In-Reply-To: <Pine.LNX.4.44.0209261712420.20778-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0209261712420.20778-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 26 Sep 2002 17:48:12 +0100
Message-Id: <1033058892.11848.102.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-09-26 at 16:27, Ingo Molnar wrote:
> > Trust me, you'll have to use the page list approach.
> 
> yeah, will try that now. I'm a bit worried about the mandatory cross-CPU
> TLB flushes though.

Wouldn't splitting the vm area also be cleaner - that would let you get
things like correct address space accounting too.

