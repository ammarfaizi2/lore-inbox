Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265014AbSJaA4g>; Wed, 30 Oct 2002 19:56:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265062AbSJaA4g>; Wed, 30 Oct 2002 19:56:36 -0500
Received: from 3-090.ctame701-1.telepar.net.br ([200.193.161.90]:7858 "EHLO
	3-090.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S265014AbSJaA4e>; Wed, 30 Oct 2002 19:56:34 -0500
Date: Wed, 30 Oct 2002 23:02:43 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: marco@reimeika.ca
cc: linux-kernel@vger.kernel.org
Subject: Re: Crazy idle values with 2.4.18-17.7.x
In-Reply-To: <20021030155803.F189806@math.utoronto.ca>
Message-ID: <Pine.LNX.4.44L.0210302301280.1697-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Oct 2002, marco wrote:

> Apologies in advance if Red Hat kernels should not be discussed
> here (pointers are appreciated).

> CPU states:  0.1% user,  0.1% system, 99.8% nice, 857278.7% idle

Idle time in the kernel can go backwards (due to a silly calculation)
and this can make the time in top overflow.

I think Red Hat has a patch in their procps rpm to catch this, but
I guess that one only catches negative overflow ;)

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://distro.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>

