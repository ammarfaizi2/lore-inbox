Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262808AbSLBMmi>; Mon, 2 Dec 2002 07:42:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262821AbSLBMmi>; Mon, 2 Dec 2002 07:42:38 -0500
Received: from 5-106.ctame701-1.telepar.net.br ([200.193.163.106]:7055 "EHLO
	5-106.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S262808AbSLBMmh>; Mon, 2 Dec 2002 07:42:37 -0500
Date: Mon, 2 Dec 2002 10:50:03 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Javier Marcet <jmarcet@pobox.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rmap15a incremental diff against 2.4.20-ac1
In-Reply-To: <20021202032448.GA26608@jerry.marcet.dyndns.org>
Message-ID: <Pine.LNX.4.44L.0212021048520.15981-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; FORMAT=flowed
Content-ID: <Pine.LNX.4.44L.0212021048522.15981@imladris.surriel.com>
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Dec 2002, Javier Marcet wrote:

> There was no inconsistency but in three spots.

Your changes look good. Maybe the lookup_swapcache() thing would
be more beautiful, but it's equivalent to the code you've got in
place. Your patch should just work.

> Feel free to try it. I'm running it right now and so far no problems.
> The vm usage has definitely improved, but there are still slight stalls
> when there's a high disk io. Say, in periods of ~2-3s the system stopped
> responding for a few cents of a sec, as if it had tachycardia.

That's probably the disk IO scheduler.

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://guru.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>

