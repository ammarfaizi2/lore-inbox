Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261706AbSJMT61>; Sun, 13 Oct 2002 15:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261711AbSJMT61>; Sun, 13 Oct 2002 15:58:27 -0400
Received: from 2-225.ctame701-1.telepar.net.br ([200.193.160.225]:18367 "EHLO
	2-225.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S261706AbSJMT6Z>; Sun, 13 Oct 2002 15:58:25 -0400
Date: Sun, 13 Oct 2002 18:04:02 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: 2.5.42-mm2
In-Reply-To: <20021013195236.GC27878@holomorphy.com>
Message-ID: <Pine.LNX.4.44L.0210131803400.22735-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Oct 2002, William Lee Irwin III wrote:

> (1) It's embedded in struct zone, hence bootmem allocated, hence
> 	already zeroed.

The struct zone doesn't get automatically zeroed on all architectures.

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://distro.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>

