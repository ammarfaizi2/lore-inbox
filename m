Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261866AbSIYBEN>; Tue, 24 Sep 2002 21:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261869AbSIYBEN>; Tue, 24 Sep 2002 21:04:13 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:44738 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261866AbSIYBEN>; Tue, 24 Sep 2002 21:04:13 -0400
Date: Tue, 24 Sep 2002 18:08:59 -0700 (PDT)
From: Dave Hansen <dave@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>
cc: William Lee Irwin III <wli@holomorphy.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.38-mm2 dbench $N times
In-Reply-To: <3D9103EB.FC13A744@digeo.com>
Message-ID: <Pine.LNX.4.44.0209241802120.11685-100000@nighthawk.sr71.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Sep 2002, Andrew Morton wrote:

> William Lee Irwin III wrote:
> > 
> > William Lee Irwin III wrote:
> > >> Taken on 32x/32G NUMA-Q:
> > >> Throughput 67.3949 MB/sec (NB=84.2436 MB/sec  673.949 MBit/sec)  16 procs
> > >> dbench 16  11.72s user 122.21s system 422% cpu 31.733 total
>
> dbench 16 on that sort of machine is a memory bandwidth test.
> And a dcache lock exerciser.  It basically doesn't touch the
> disk.  Something very bad is happening.
> 
> Anton can get 3000 MByte/sec ;)

Bill's Machine cost around $50, plus the cost to repair the walls that I 
crushed when hauling the pieces around.  Anton's cost $2 million.  Bill 
wins :)

Are you trying to bind the processes anywhere?  I wonder what would happen 
if you make it always run quad 0...
-- 
Dave Hansen
haveblue@us.ibm.com

