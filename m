Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314422AbSE2RrS>; Wed, 29 May 2002 13:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314325AbSE2RrR>; Wed, 29 May 2002 13:47:17 -0400
Received: from sex.inr.ac.ru ([193.233.7.165]:54178 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S314459AbSE2RrP>;
	Wed, 29 May 2002 13:47:15 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200205291744.VAA02877@sex.inr.ac.ru>
Subject: Re: 8-CPU (SMP) #s for lockfree rtcache
To: rml@tech9.NET (Robert Love)
Date: Wed, 29 May 2002 21:44:34 +0400 (MSD)
Cc: davem@redhat.com (Dave Miller), linux-kernel@vger.kernel.org
In-Reply-To: <1022600998.20317.44.camel@sinai> from "Robert Love" at May 28, 2 08:15:02 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> I also balk at implicit locking...

rcu is not implicit. At least in the only demo, which I have read
i.e. in routing cache, it is more explicit than spinlocks are. :-)

I also strongly dislike any kind of implicit serialization and even
not standard serialization. So, rcu used in route.c is supposed
to be cleaned of assembly style code and converted to something
more intelligible.

Alexey
