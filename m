Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267271AbTA0SYG>; Mon, 27 Jan 2003 13:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267274AbTA0SYF>; Mon, 27 Jan 2003 13:24:05 -0500
Received: from 216-42-72-148.ppp.netsville.net ([216.42.72.148]:53643 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id <S267271AbTA0SYC>;
	Mon, 27 Jan 2003 13:24:02 -0500
Subject: Re: [PATCH] data logging patches available for 2.4.21-preX
From: Chris Mason <mason@suse.com>
To: Dieter =?ISO-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Manuel Krause <manuel.krause@mb.tu-ilmenau.de>,
       "J.A. Magallon" <jamagallon@able.es>
In-Reply-To: <200301271914.26312.Dieter.Nuetzel@hamburg.de>
References: <200301271914.26312.Dieter.Nuetzel@hamburg.de>
Content-Type: text/plain; charset=ISO-8859-1
Organization: 
Message-Id: <1043692402.15680.58.camel@tiny.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 27 Jan 2003 13:33:22 -0500
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-01-27 at 13:14, Dieter Nützel wrote:

> Hello Chris,
> 
> as always very nice work!
> I have it now running fine on top of 2.4.21-pre3-jam3 (2.4.21-pre3aa1).
> Some fiddling was necessary but went smooth after all.
> My /home partition is mounted with -o data=ordered and the performance is 
> great. Sorry, no real benchmarks, yet.
> 

Thanks for trying them out.

> But some question stay open:
> Where is 01-akpm-sync_fs-fix-2.diff

01-akpm-sync_fs-fix-2.diff is in the 2.4.21 data logging directory you
linked to below.

>  and 01-iput-deadlock-fix.diff?

This is in the namesys pending directory, but doesn't apply cleanly
yet.  I'm rediffing both the quota code and the data logging code on top
of 01-iput-deadlock-fix (or I might just steal Manuel's rediff, which is
still in my linuxworld backlog).  

> Isn't it needed anylonger 'cause you merged them and SuSE's ftp isn't updated 
> yet? All files are the "old" one's from 15. January.
> ftp://ftp.suse.com/pub/people/mason/patches/data-logging/2.4.21
> 
> What about patch-2.4.20.rfs.06.05-transaction-overflow-fix-0.diff?
> Should I put it on top, too?

That is included in 05-data-logging-33.

-chris

