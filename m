Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131669AbRAGTiB>; Sun, 7 Jan 2001 14:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131953AbRAGThv>; Sun, 7 Jan 2001 14:37:51 -0500
Received: from nnj-dialup-61-227.nni.com ([216.107.61.227]:6080 "EHLO
	nnj-dialup-61-227.nni.com") by vger.kernel.org with ESMTP
	id <S131669AbRAGThh>; Sun, 7 Jan 2001 14:37:37 -0500
Date: Sun, 7 Jan 2001 14:35:59 -0500 (EST)
From: TenThumbs <tenthumbs@cybernex.net>
Reply-To: TenThumbs <tenthumbs@cybernex.net>
To: Thiago Rondon <maluco@mileniumnet.com.br>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.19pre6 change in /proc behavior
In-Reply-To: <Pine.LNX.4.21.0101061423460.13574-100000@freak.mileniumnet.com.br>
Message-ID: <Pine.LNX.4.21.0101071433490.171-100000@perfect.master>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Jan 2001, Thiago Rondon wrote:

> 
> At 2.4 too, but the status of file is o+r. Do see any
> problem about this?
> 
> -Thiago Rondon
> 

Yes. /proc/<pid>/environ is now unreadable by the owner; similarly for
/proc/<pid>/fd/ . It makes debugging harder.

It is also a major change in a supposedly stable series.

-- 
Uranus
    2001-01-07 19:33:49.989 UTC (JD 2451917.315162)
    X  =  15.385597320, Y  = -11.563171292, Z  =  -5.281988673
    X' =   0.002476083, Y' =   0.002622687, Z' =   0.001113647

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
