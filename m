Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261486AbSKXRcT>; Sun, 24 Nov 2002 12:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261492AbSKXRcT>; Sun, 24 Nov 2002 12:32:19 -0500
Received: from 1-245.ctame701-1.telepar.net.br ([200.181.137.245]:63422 "EHLO
	1-245.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S261486AbSKXRcS>; Sun, 24 Nov 2002 12:32:18 -0500
Date: Sun, 24 Nov 2002 15:39:15 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Nero <neroz@iinet.net.au>
cc: lkml <linux-kernel@vger.kernel.org>, Con Kolivas <conman@kolivas.net>
Subject: Re: [BENCHMARK] rmap15, rmap14c and rc1aa1 with contest
In-Reply-To: <3DE0D157.9020906@iinet.net.au>
Message-ID: <Pine.LNX.4.44L.0211241538240.4103-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Nov 2002, Nero wrote:

> read_load:
> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> 2.4.19-rmap15 [1]       0.0     0       0       7       0.00
> 2.4.19-rmap14c [1]      121.0   72      20      7       1.44
> 2.4.20-rc1aa1 [1]       111.2   79      34      14      inf
>
> rmap15 OOM'd the cc1 process twice and fscked this run up.

Known bug, should be fixed with the 2.4.19-rmap15-splitactive
patch I posted on friday:

	http://surriel.com/patches/2.4/2.4.19-rmap15-splitactive

cheers,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://guru.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>

