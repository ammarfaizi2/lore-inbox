Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316853AbSHXW7G>; Sat, 24 Aug 2002 18:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316856AbSHXW7G>; Sat, 24 Aug 2002 18:59:06 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:58822 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S316853AbSHXW7F>;
	Sat, 24 Aug 2002 18:59:05 -0400
Message-ID: <1030230196.3d6810b4aa1ff@kolivas.net>
Date: Sun, 25 Aug 2002 09:03:16 +1000
From: conman@kolivas.net
To: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
Subject: Re: Preempt note in the logs
References: <Pine.LNX.4.44.0208241157590.3234-100000@hawkeye.luckynet.adm> <1030212663.861.3.camel@phantasy>
In-Reply-To: <1030212663.861.3.camel@phantasy>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert

Sorry you're getting involved in this. It all centres around me merging a few of
the more popular performance patches [O(1),preempt,low latency,rmap]. 

The preempt count in the log they're referring to only occurs frequently with my
patches so it's not due to your code; it happens with every single process using
my butchered patch. I based the merging on your latest patch for 2.4.19 and a
previous patch you had created for preempt on O(1) for 2.4.18

http://kernel.kolivas.net

I don't expect you to debug this, and I expect it's a fault in my version of
sched.c (most obvious choice).

Cheers,
Con Kolivas

