Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316043AbSHIVje>; Fri, 9 Aug 2002 17:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316088AbSHIVje>; Fri, 9 Aug 2002 17:39:34 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:57614 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316043AbSHIVjc>; Fri, 9 Aug 2002 17:39:32 -0400
Date: Fri, 9 Aug 2002 14:42:59 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Paul Larson <plars@austin.ibm.com>
cc: Hubertus Franke <frankeh@us.ibm.com>, Rik van Riel <riel@conectiva.com.br>,
       Andries Brouwer <aebr@win.tue.nl>, Andrew Morton <akpm@zip.com.au>,
       <andrea@suse.de>, Dave Jones <davej@suse.de>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Linux-2.5 fix/improve get_pid()
In-Reply-To: <Pine.LNX.4.33.0208091420240.19267-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.31.0208091441270.29869-100000@torvalds-p95.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 9 Aug 2002, Linus Torvalds wrote:
>
> There are various /proc paths, Andries had a full patch at some point a
> long time ago.

Hmm.. Giving them a quick glance-over, the /proc issues look like they
shouldn't be there in 2.5.x anyway, since the inode number really is
largely just a random number in 2.5 and all the real information is
squirelled away at path open time.

There's certainly a possibility for some cleanups, though.

		Linus

