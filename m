Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262468AbSIWMy4>; Mon, 23 Sep 2002 08:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262483AbSIWMy4>; Mon, 23 Sep 2002 08:54:56 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:58250 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S262468AbSIWMyz>;
	Mon, 23 Sep 2002 08:54:55 -0400
Message-ID: <1032786004.3d8f1054cc069@kolivas.net>
Date: Mon, 23 Sep 2002 23:00:04 +1000
From: Con Kolivas <conman@kolivas.net>
To: andersen@codepoet.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] Corrected gcc3.2 v gcc2.95.3 contest results
References: <Pine.LNX.4.44.0209230945260.2917-100000@localhost.localdomain> <1032777021.3d8eed3d55f53@kolivas.net> <20020923124730.GA7556@codepoet.org>
In-Reply-To: <20020923124730.GA7556@codepoet.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Erik Andersen <andersen@codepoet.org>:

> On Mon Sep 23, 2002 at 08:30:21PM +1000, Con Kolivas wrote:
> > Yes you make a very valid point and something I've been stewing over
> privately
> > for some time. contest runs benchmarks in a fixed order with a "priming"
> compile
> > to try and get pagecaches etc back to some sort of baseline (I've been
> trying
> > hard to make the results accurate and repeatable). 
> 
> It would sure be nice for this sortof test if there were
> some sort of a "flush-all-caches" syscall...

For the moment I think I'll also add a swapoff/swapon before each compile as
well (thanks Luuk for the suggestion). I'm still looking at the raw data to
figure out what to do.

Con.
