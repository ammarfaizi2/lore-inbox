Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318382AbSGRWVI>; Thu, 18 Jul 2002 18:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318394AbSGRWVI>; Thu, 18 Jul 2002 18:21:08 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:3085 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S318382AbSGRWTm>; Thu, 18 Jul 2002 18:19:42 -0400
Date: Thu, 18 Jul 2002 19:22:17 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Szakacsits Szabolcs <szaka@sienet.hu>
cc: Robert Love <rml@tech9.net>, <linux-mm@kvack.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] strict VM overcommit for stock 2.4
In-Reply-To: <Pine.LNX.4.30.0207181930170.30902-100000@divine.city.tvnet.hu>
Message-ID: <Pine.LNX.4.44L.0207181921500.12241-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jul 2002, Szakacsits Szabolcs wrote:
> On Thu, 18 Jul 2002, Szakacsits Szabolcs wrote:
> > And my point (you asked for comments) was that, this is only (the
> > harder) part of the solution making Linux a more reliable (no OOM
> > killing *and* root always has the control) and cost effective platform
> > (no need for occasionally very complex and continuous resource limit
> > setup/adjusting, especially for inexpert home/etc users).
>
> Ahh, I figured out your target, embedded devices. Yes it's good for
> that but not enough for general purpose.

However, you NEED this patch in order to implement something
that is good enough for general purpose (ie. per-user resource
accounting).

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

