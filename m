Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269158AbSIRTfL>; Wed, 18 Sep 2002 15:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269172AbSIRTfK>; Wed, 18 Sep 2002 15:35:10 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:62738 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S269158AbSIRTfJ>; Wed, 18 Sep 2002 15:35:09 -0400
Date: Wed, 18 Sep 2002 16:39:48 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Mark_H_Johnson@raytheon.com
Cc: Andrew Morton <akpm@digeo.com>, <linux-kernel@vger.kernel.org>,
       <linux-mm@kvack.org>, <owner-linux-mm@kvack.org>
Subject: Re: [PATCH] recognize MAP_LOCKED in mmap() call
In-Reply-To: <OFC0C42F8D.E1325D58-ON86256C38.00695CD8@hou.us.ray.com>
Message-ID: <Pine.LNX.4.44L.0209181639260.1519-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Sep 2002 Mark_H_Johnson@raytheon.com wrote:
> Andrew Morton wrote:
> >(SuS really only anticipates that mmap needs to look at prior mlocks
> >in force against the address range.  It also says
> >
> >     Process memory locking does apply to shared memory regions,
> >
> >and we don't do that either.  I think we should; can't see why SuS
> >requires this.)
>
> Let me make sure I read what you said correctly. Does this mean that
> Linux 2.4 (or 2.5) kernels do not lock shared memory regions if a
> process uses mlockall?

But it does.  Linux won't evict memory that's MLOCKed...

cheers,

Rik
-- 
Spamtrap of the month: september@surriel.com

http://www.surriel.com/		http://distro.conectiva.com/

