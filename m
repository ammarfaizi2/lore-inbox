Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262100AbSJ2RWG>; Tue, 29 Oct 2002 12:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262083AbSJ2RWG>; Tue, 29 Oct 2002 12:22:06 -0500
Received: from 3-090.ctame701-1.telepar.net.br ([200.193.161.90]:16037 "EHLO
	3-090.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S262100AbSJ2RWF>; Tue, 29 Oct 2002 12:22:05 -0500
Date: Tue, 29 Oct 2002 15:28:00 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Bill Davidsen <davidsen@tmr.com>
cc: Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>,
       <linux-mm@kvack.org>
Subject: Re: 2.5.44-mm6
In-Reply-To: <Pine.LNX.3.96.1021029065944.6113B-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.44L.0210291526560.1697-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Oct 2002, Bill Davidsen wrote:
> On Mon, 28 Oct 2002, Andrew Morton wrote:
> > Rik van Riel wrote:
> > > Just let me know if you're interested in my load control mechanism
> > > and I'll send it to you.
> > It would also be interesting to know if we really care?
>
> I think there is a need for keeping an overloaded machine in some way
> usable, not because anyone is really running it that way, but because
> the sysadmin needs a way to determine why a correctly sized machine is
> suddenly seeing a high load.

Indeed, it's a stability thing, not a performance thing.

It's Not Good(tm) to have a system completely crap out because
of a load spike. Instead it should survive the load spike and
go on with life.

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://distro.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>

