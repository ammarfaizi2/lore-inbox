Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317590AbSGTXx7>; Sat, 20 Jul 2002 19:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317589AbSGTXx6>; Sat, 20 Jul 2002 19:53:58 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:9968 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317590AbSGTXx5>; Sat, 20 Jul 2002 19:53:57 -0400
Subject: Re: [PATCH] VM strict overcommit
From: Robert Love <rml@tech9.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@zip.com.au, Linus Torvalds <torvalds@transmeta.com>,
       riel@conectiva.com.br, linux-kernel@vger.kernel.org
In-Reply-To: <1027213161.16818.65.camel@irongate.swansea.linux.org.uk>
References: <1027196403.1086.751.camel@sinai> 
	<1027211556.17234.55.camel@irongate.swansea.linux.org.uk> 
	<1027207835.1116.861.camel@sinai> 
	<1027213161.16818.65.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 20 Jul 2002 16:56:44 -0700
Message-Id: <1027209404.1085.891.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-07-20 at 17:59, Alan Cox wrote:

> When did you send me mail - I certainly never saw it. 

I can forward you the email if you like.  Same goes for your reply :)

> If its actually a serious concern, eg for some of the weirder embedded
> stuff you guys run at Montavista then I'd suggest changing it to have 
> three modes
> 
> 0 and 1 as before
> 
> 2 - some percentage of memory (default 50), and expose the percentage
> setting by sysctl too.
> 
> That allows people to experiment, handles weird cases and deals with the
> problem.

This is the way to go -- we should do this.  Good idea.

	Robert Love

