Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131407AbRDYTQu>; Wed, 25 Apr 2001 15:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131479AbRDYTQ3>; Wed, 25 Apr 2001 15:16:29 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:21261 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131497AbRDYTQ1>; Wed, 25 Apr 2001 15:16:27 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: a fork-like C-wrapper for clone(), DONE!
Date: 25 Apr 2001 12:15:51 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9c77p7$upd$1@cesium.transmeta.com>
In-Reply-To: <3AE6CD6B.745E@mat.upc.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3AE6CD6B.745E@mat.upc.es>
By author:    Francesc Oller <francesc@mat.upc.es>
In newsgroup: linux.dev.kernel
>
> Hi all,
> 
> Some days before I asked for a fork-like C-wrapper for clone() which
> could be used like fork() thinking that somebody could have done it
> before but I only received two e-mails saying that probably it
> wasn't worth it or even it was complete non-sense.
> 
> Therefore, I've done it myself. Code follows.
> 
> Please, before beginning to flame me for doing "such kind of non-
> standard threading model", I've to say that IMHO it has some merit.
> After all it was E.W.Dijkstra who invented it in the late sixties.
> 

glibc already contains such a wrapper; it is called __clone().  At
least my system has "man clone" show the man page for it.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
