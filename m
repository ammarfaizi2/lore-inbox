Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266010AbSLYB0a>; Tue, 24 Dec 2002 20:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266020AbSLYB03>; Tue, 24 Dec 2002 20:26:29 -0500
Received: from 5-116.ctame701-1.telepar.net.br ([200.193.163.116]:54681 "EHLO
	5-116.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S266010AbSLYB03>; Tue, 24 Dec 2002 20:26:29 -0500
Date: Tue, 24 Dec 2002 23:34:26 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: jw schultz <jw@pegasys.ws>
cc: linux-kernel@vger.kernel.org
Subject: Re: Horrible drive performance under concurrent i/o jobs (dlh
 problem?)
In-Reply-To: <20021224172122.GB30929@pegasys.ws>
Message-ID: <Pine.LNX.4.50L.0212242330490.26879-100000@imladris.surriel.com>
References: <000d01c2a8b6$3d102e20$941e1c43@joe> <B7CC2AA8-1720-11D7-8DC6-000393950CC2@karlsbakk.net>
 <20021224172122.GB30929@pegasys.ws>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Dec 2002, jw schultz wrote:

> The rotational frequency should be 7200*60/sec which makes
> for 2.31 us which would produce an average rotational
> latency of 1.16us if such a condition even still applies.

That would be 432000 rotations per second, meaning that the
edge of a 3.5" disk would travel at almost 120 kilometers per
second and be stressed by some pretty impressive G forces,
which I'm too lazy to calculate.

Good thing a 7200 RPM disk only spins 120 times a second,
that's a lot safer in consumer applications. ;)

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://guru.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>
