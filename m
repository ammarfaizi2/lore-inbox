Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131631AbRCXK3o>; Sat, 24 Mar 2001 05:29:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131632AbRCXK3e>; Sat, 24 Mar 2001 05:29:34 -0500
Received: from relay02.cablecom.net ([62.2.33.102]:28432 "EHLO
	relay02.cablecom.net") by vger.kernel.org with ESMTP
	id <S131631AbRCXK3a>; Sat, 24 Mar 2001 05:29:30 -0500
Message-ID: <3ABC76D8.F7D59CCC@bluewin.ch>
Date: Sat, 24 Mar 2001 11:28:40 +0100
From: Otto Wyss <otto.wyss@bluewin.ch>
Reply-To: otto.wyss@bluewin.ch
X-Mailer: Mozilla 4.76 (Macintosh; U; PPC)
X-Accept-Language: de,en
MIME-Version: 1.0
To: David Ford <david@blue-labs.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux should better cope with power failure
In-Reply-To: <3ABB6B82.62293CAD@uni-mb.si> <3ABBA400.2AEC97E8@bluewin.ch> <3ABBD11D.FE20FB69@blue-labs.org> <3ABC5E89.FB6A2C89@bluewin.ch> <3ABC6D18.337E5089@blue-labs.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > You probably haven't tried to use sync or you would have noticed the
> > performace penalty. I think nobody really considers sync an alternative.
> >
> > O. Wyss
> 
> You can't have the best of everything.  There are tradeoffs.  A viable option is > a journaled filesystem.  Linux boasts a few, two of which are at your fingertips > by way of config options.  Read up on JFS or ReiserFS.
> 
How about the following solution: During high activity _any_ FS is
treated as if it were mounted asynch, during low/no activity it's
treaded as synch. This simple solution certainly will be acceptable for anyone.

O. Wyss
