Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317582AbSGTX1s>; Sat, 20 Jul 2002 19:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317590AbSGTX1s>; Sat, 20 Jul 2002 19:27:48 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:21487 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317582AbSGTX1r>; Sat, 20 Jul 2002 19:27:47 -0400
Subject: Re: [PATCH] VM strict overcommit
From: Robert Love <rml@tech9.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@zip.com.au, Linus Torvalds <torvalds@transmeta.com>,
       riel@conectiva.com.br, linux-kernel@vger.kernel.org
In-Reply-To: <1027211556.17234.55.camel@irongate.swansea.linux.org.uk>
References: <1027196403.1086.751.camel@sinai> 
	<1027211556.17234.55.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 20 Jul 2002 16:30:35 -0700
Message-Id: <1027207835.1116.861.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-07-20 at 17:32, Alan Cox wrote:

> Your 95% mode is pure crap. I tried various values and I can assure you
> that your code will fail dismally to do anything useful unless you are
> below 65% when running Oracle for example.

Relax Alan.  Nothing is set in stone and we need to pick some number to
start playing with.

My test suite was _not_ Oracle (and who would run Oracle on a swapless
machine?) and I was not able to OOM the machine with my tests.  I in no
way contend 95% is perfect.  Even your 50% mode is not (nothing but
solely backing store can make any guarantees).

But "works for me" is a start and we can work on tuning it.  No
"swapless" mode will be perfect and while 65% may work for, another load
with gross overhead may need more room.

I sent you an email and told you I was doing this and asked your opinion
on a percentage.  Why are you picking on me now?

	Robert Love

