Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317602AbSGTXzJ>; Sat, 20 Jul 2002 19:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317600AbSGTXzI>; Sat, 20 Jul 2002 19:55:08 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:19184 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317598AbSGTXzG>; Sat, 20 Jul 2002 19:55:06 -0400
Subject: Re: [PATCH] VM strict overcommit
From: Robert Love <rml@tech9.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@zip.com.au, Linus Torvalds <torvalds@transmeta.com>,
       riel@conectiva.com.br, linux-kernel@vger.kernel.org
In-Reply-To: <1027213626.16819.74.camel@irongate.swansea.linux.org.uk>
References: <1027196403.1086.751.camel@sinai> 
	<1027211556.17234.55.camel@irongate.swansea.linux.org.uk> 
	<1027207835.1116.861.camel@sinai> 
	<1027213161.16818.65.camel@irongate.swansea.linux.org.uk> 
	<1027213626.16819.74.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 20 Jul 2002 16:57:48 -0700
Message-Id: <1027209468.1555.893.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-07-20 at 18:07, Alan Cox wrote:

> Ok I take that back. It merely never got as far into my brain as to stay
> stuck. 

No problem.

> Lets go with a sysctl tuned value and see what the 2.5 world finds the
> best numbers to be ?

Great idea.  This allows pedants with swap to use 0, others to use 50,
and those without swap to pick whatever works for them (e.g. 65% as you
suggest).

	Robert Love

