Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261687AbSJMTwE>; Sun, 13 Oct 2002 15:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261681AbSJMTvj>; Sun, 13 Oct 2002 15:51:39 -0400
Received: from 2-225.ctame701-1.telepar.net.br ([200.193.160.225]:50366 "EHLO
	2-225.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S261687AbSJMTvb>; Sun, 13 Oct 2002 15:51:31 -0400
Date: Sun, 13 Oct 2002 17:57:06 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Mark Hahn <hahn@physics.mcmaster.ca>
cc: Brian Jackson <brian-kernel-list@mdrx.com>, <linux-kernel@vger.kernel.org>,
       <evms-devel@lists.sourceforge.net>
Subject: Re: Linux v2.5.42
In-Reply-To: <Pine.LNX.4.33.0210131545510.17395-100000@coffee.psychology.mcmaster.ca>
Message-ID: <Pine.LNX.4.44L.0210131755340.22735-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Oct 2002, Mark Hahn wrote:

> > Yes I do realize that, but I think EVMS offers more in the long run than any
> > of the others.
>
> not to put too find a point on it, but IBM has their own goals. for
> instance, some part of EVMS design is motivated by IBM's political
> desire to permit its bank customers, who have horrible old OS/2 systems,
> to transparently use OS/2 volumes.  it's not as if IBM couldn't provide
> a simple, user-level migration tool.

You don't need a migration tool.

All you need is:

1) a kernel level driver that can map devices, ie. a device mapper

2) user space tools that can parse the volume metadata and tell the
   kernel how to map each chunk at initialisation or mount time

You don't need a flying circus in kernel space.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://distro.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>

