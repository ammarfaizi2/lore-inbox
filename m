Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262692AbSJTOZU>; Sun, 20 Oct 2002 10:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262708AbSJTOZU>; Sun, 20 Oct 2002 10:25:20 -0400
Received: from 2-136.ctame701-1.telepar.net.br ([200.193.160.136]:60137 "EHLO
	2-136.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S262692AbSJTOZS>; Sun, 20 Oct 2002 10:25:18 -0400
Date: Sun, 20 Oct 2002 12:31:07 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Con Kolivas <conman@kolivas.net>
cc: Jim Houston <jim.houston@attbi.com>, <linux-kernel@vger.kernel.org>,
       <mingo@elte.hu>, <andrea@suse.de>, <jim.houston@ccur.com>,
       <akpm@digeo.com>
Subject: Re: [PATCH] Re: Pathological case identified from contest
In-Reply-To: <200210201733.44683.conman@kolivas.net>
Message-ID: <Pine.LNX.4.44L.0210201230070.22993-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Oct 2002, Con Kolivas wrote:

> The rest of the results were otherwise similar. It seems your patch
> served to disadvantage kernel compilation in preference for more of the
> background load.

Probably a priority inheritance thing between parent and child
processes, this should be easily fixable to be fairer (if it
isn't already fairest with Jim's patch).

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://distro.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>

