Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317058AbSGTAE0>; Fri, 19 Jul 2002 20:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317232AbSGTAE0>; Fri, 19 Jul 2002 20:04:26 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:9230 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S317058AbSGTAEZ>; Fri, 19 Jul 2002 20:04:25 -0400
Date: Fri, 19 Jul 2002 21:07:07 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Austin Gonyou <austin@digitalroadkill.net>
cc: Johannes Erdfelt <johannes@erdfelt.com>, David Rees <dbr@greenhydrant.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19rc2aa1 VM too aggressive?
In-Reply-To: <1027117945.7776.11.camel@UberGeek>
Message-ID: <Pine.LNX.4.44L.0207192105160.12241-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Jul 2002, Austin Gonyou wrote:

> Notice you're memory utilization jumps here as your free is given to
> cache.

Swinging back and forth 150 MB per second seems a bit excessive
for that, especially considering that the previously cached
memory seems to end up on the free list and the fact that there
is between 350 and 500 MB free memory.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/


