Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272836AbRISS6N>; Wed, 19 Sep 2001 14:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272773AbRISS6D>; Wed, 19 Sep 2001 14:58:03 -0400
Received: from puma.inf.ufrgs.br ([143.54.11.5]:29967 "EHLO inf.ufrgs.br")
	by vger.kernel.org with ESMTP id <S272836AbRISS5t>;
	Wed, 19 Sep 2001 14:57:49 -0400
Date: Wed, 19 Sep 2001 15:58:49 -0300 (EST)
From: Roberto Jung Drebes <drebes@inf.ufrgs.br>
To: linux-kernel@vger.kernel.org
Subject: Re: Re[2]: [PATCH] Athlon bug stomper. Pls apply.
In-Reply-To: <Pine.LNX.4.30.0109191141560.24917-100000@anime.net>
Message-ID: <Pine.GSO.4.21.0109191552400.12342-100000@jacui>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Sep 2001, Dan Hollis wrote:

> AFAIK noone has even tested it yet to see what it does to performance! Eg
> it might slow down memory access so that athlon-optimized memcopy is now
> slower than non-athlon-optimized memcopy. And if it turns out to be the
> case, we might as well just use the non-athlon-optimized memcopy instead
> of twiddling undocumented northbridge bits...

How can I test it? Can someone point me to a simple program to do it? Then
I could run it over the non-optimized, the optimized in the good bios and
the optimized in the bad bios plus patch to test it.

Altough my system shows the bug, I am not sure if we should add the patch
as the default option right now. Actually, we don´t have a clue if the
only thing this bit is doing is solving the bug or if it is going to be
responsible for an unknown and unnoticed bug that will show up later. Why
rush things up? Can´t we wait a word from VIA and then decide what to
do? What could be done is to put this patch somewhere other than the list
where we can point people that come to lkml with this problem to.

--
Roberto Jung Drebes <drebes@inf.ufrgs.br>
Porto Alegre, RS - Brasil
http://www.inf.ufrgs.br/~drebes/

