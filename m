Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313014AbSDYIvQ>; Thu, 25 Apr 2002 04:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313016AbSDYIvP>; Thu, 25 Apr 2002 04:51:15 -0400
Received: from johnsl.lnk.telstra.net ([139.130.12.152]:2579 "HELO
	ns.higherplane.net") by vger.kernel.org with SMTP
	id <S313014AbSDYIvP>; Thu, 25 Apr 2002 04:51:15 -0400
Date: Thu, 25 Apr 2002 18:52:37 +1000
From: john slee <indigoid@higherplane.net>
To: ebuddington@wesleyan.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: Dissociating process from bin's filesystem
Message-ID: <20020425085237.GE17717@higherplane.net>
In-Reply-To: <20020424224714.B19073@ma-northadams1b-46.bur.adelphia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2002 at 10:47:14PM -0400, Eric Buddington wrote:
> Is there any way to dissociate a process from its on-disk binary?  In
> other words, I want to start 'foo_daemon', then unmount the filesystem
> it started from. It seems to me this would be reasonably accomplished
> by loading the binary completely into memory first ro eliminate the
> dependence.
> 
> Is this possible, or planned? Are there intractable problems with it
> that I don't see?

as i understand it this precludes you from using shared libs as they are
mmap()'d on startup...

other than that the running daemon will cause the fs to be
un-umountable.

j.

-- 
R N G G   "Well, there it goes again... And we just sit 
 I G G G   here without opposable thumbs." -- gary larson
