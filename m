Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261640AbTBJET4>; Sun, 9 Feb 2003 23:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261615AbTBJET4>; Sun, 9 Feb 2003 23:19:56 -0500
Received: from 3-157.ctame701-1.telepar.net.br ([200.193.161.157]:17038 "EHLO
	3-157.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S261640AbTBJET4>; Sun, 9 Feb 2003 23:19:56 -0500
Date: Mon, 10 Feb 2003 02:29:20 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: David Lang <david.lang@digitalinsight.com>
cc: Andrea Arcangeli <andrea@suse.de>, Con Kolivas <ckolivas@yahoo.com.au>,
       lkml <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK]
 2.4.20-ck3 / aa / rmap with contest]
In-Reply-To: <Pine.LNX.4.44.0302092018180.15944-100000@dlang.diginsite.com>
Message-ID: <Pine.LNX.4.50L.0302100228140.12742-100000@imladris.surriel.com>
References: <Pine.LNX.4.44.0302092018180.15944-100000@dlang.diginsite.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Feb 2003, David Lang wrote:

> note that issuing a fsync should change all pending writes to 'syncronous'
> as should writes to any partition mounted with the sync option, or writes
> to a directory with the S flag set.

Exactly.  This is nasty with our current data structures;
probably not something to do during the current code slush.

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://guru.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>
