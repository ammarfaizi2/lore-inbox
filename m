Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316855AbSGWXtE>; Tue, 23 Jul 2002 19:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318277AbSGWXtE>; Tue, 23 Jul 2002 19:49:04 -0400
Received: from [195.223.140.120] ([195.223.140.120]:12106 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S316855AbSGWXtA>; Tue, 23 Jul 2002 19:49:00 -0400
Date: Wed, 24 Jul 2002 01:52:54 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Austin Gonyou <austin@digitalroadkill.net>,
       Johannes Erdfelt <johannes@erdfelt.com>,
       David Rees <dbr@greenhydrant.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19rc2aa1 VM too aggressive?
Message-ID: <20020723235254.GB1117@dualathlon.random>
References: <1027117945.7776.11.camel@UberGeek> <Pine.LNX.4.44L.0207192105160.12241-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0207192105160.12241-100000@imladris.surriel.com>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2002 at 09:07:07PM -0300, Rik van Riel wrote:
> On 19 Jul 2002, Austin Gonyou wrote:
> 
> > Notice you're memory utilization jumps here as your free is given to
> > cache.
> 
> Swinging back and forth 150 MB per second seems a bit excessive
> for that, especially considering that the previously cached
> memory seems to end up on the free list and the fact that there
> is between 350 and 500 MB free memory.

if the app allocates and frees 150MB of shm per second that's what the
kernel has to show you.

Andrea
