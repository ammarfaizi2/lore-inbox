Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287535AbSASWT7>; Sat, 19 Jan 2002 17:19:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287502AbSASWTu>; Sat, 19 Jan 2002 17:19:50 -0500
Received: from mail3.svr.pol.co.uk ([195.92.193.19]:46200 "EHLO
	mail3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S287535AbSASWTd>; Sat, 19 Jan 2002 17:19:33 -0500
Date: Sat, 19 Jan 2002 22:19:29 +0000
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] O(1) scheduler updates, -J2
Message-ID: <20020119221928.A2042@sackman.co.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0201181710520.10122-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.LNX.4.33.0201181710520.10122-100000@localhost.localdomain>; from mingo@elte.hu on Fri, Jan 18, 2002 at 07:18:10PM +0100
From: matthew@sackman.co.uk (Matthew Sackman)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2002 at 07:18:10PM +0100, Ingo Molnar wrote:
> 
> the -J2 O(1) scheduler patch is available:
> 
>     http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.5.3-pre1-J2.patch
>     http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.4.17-J2.patch
<snips> 

Just a few comments on this. Compiled on 2.4.17 with gcc-2.95.4. O(1)-J2
only patch applied.

With the thread earlier regarding KDE and image thumbnails and xmms, yes
the machine is now useable whilst the images are being read and rendered,
and xmms doesn't falter, but about 2 seconds after kde finishes, xmms
falters twice (briefly - catches up very quickly).

Also, when X starts up, some of my startup settings seem to load too
quickly - I use uwm and a couple of xterms are started without the
terminal options being set (it seems) - instead of getting "user@host:~/"
on the left, I get each character on a seperate line. Also colours are
not fully set - mutt starts and then it seems the xterm bgcolour gets
applied.

Neither of these have ever happened without the O(1) patch. Please let
me know if I can be of any further assistance.

Matthew

