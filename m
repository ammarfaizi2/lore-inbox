Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317215AbSHJSp1>; Sat, 10 Aug 2002 14:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317217AbSHJSp1>; Sat, 10 Aug 2002 14:45:27 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:19653 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S317215AbSHJSp0>; Sat, 10 Aug 2002 14:45:26 -0400
Date: Sat, 10 Aug 2002 19:48:13 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Paul Larson <plars@austin.ibm.com>, Hubertus Franke <frankeh@us.ibm.com>,
       Rik van Riel <riel@conectiva.com.br>, Andries Brouwer <aebr@win.tue.nl>,
       Andrew Morton <akpm@zip.com.au>, andrea@suse.de,
       Dave Jones <davej@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Linux-2.5 fix/improve get_pid()
Message-ID: <20020810194813.D306@kushida.apsleyroad.org>
References: <20020810182317.A306@kushida.apsleyroad.org> <Pine.LNX.4.44.0208101132490.2197-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0208101132490.2197-100000@home.transmeta.com>; from torvalds@transmeta.com on Sat, Aug 10, 2002 at 11:33:10AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> > Oh dear -- what of programs that assume duplicate inode numbers are hard
> > links, and therefore assume the same contents will be found in each
> > duplicate?
> 
> Well, anybody who tries to back up /proc with "tar" is in for some 
> surprises anyway ;)

I was thinking of an over-intelligent `find'.  But hey, as long as this
is only for the weird and wonderful /proc :-)

-- Jamie
