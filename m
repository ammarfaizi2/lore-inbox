Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316594AbSHGArZ>; Tue, 6 Aug 2002 20:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316595AbSHGArZ>; Tue, 6 Aug 2002 20:47:25 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:1297 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S316594AbSHGArZ>; Tue, 6 Aug 2002 20:47:25 -0400
Date: Tue, 6 Aug 2002 21:50:50 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrew Morton <akpm@zip.com.au>
cc: William Lee Irwin III <wli@holomorphy.com>, <linux-kernel@vger.kernel.org>
Subject: Re: fix CONFIG_HIGHPTE
In-Reply-To: <3D506D43.890EA215@zip.com.au>
Message-ID: <Pine.LNX.4.44L.0208062150290.23404-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Aug 2002, Andrew Morton wrote:

> Is it likely that large pages and/or shared pagetables would allow us to
> place pagetables and pte_chains in the direct-mapped region, avoid all
> this?

For all workloads we care about, yes.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

