Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261341AbSI3VRM>; Mon, 30 Sep 2002 17:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261342AbSI3VRM>; Mon, 30 Sep 2002 17:17:12 -0400
Received: from air-2.osdl.org ([65.172.181.6]:4368 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261341AbSI3VRM>;
	Mon, 30 Sep 2002 17:17:12 -0400
Date: Mon, 30 Sep 2002 14:21:10 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: george anzinger <george@mvista.com>
cc: John Levon <movement@marcelothewonderpenguin.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/6] High-res-timers part 6 (support-man) take 2
In-Reply-To: <3D98BED5.79A73D7C@mvista.com>
Message-ID: <Pine.LNX.4.33L2.0209301419380.4649-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Sep 2002, george anzinger wrote:

| "Randy.Dunlap" wrote:
| >
| > On Sat, 28 Sep 2002, John Levon wrote:
| >
| > | On Sat, Sep 28, 2002 at 10:32:08AM -0700, george anzinger wrote:
| > |
| > | > The 4th, 5th, and 6th parts are support code and not really
| > | > part of the kernel.
| > |
| > | So ...
| > |
| > | > This part contains man pages for the new system calls.
| > |
| > | ... why are they here ?
| > |
| > | http://freshmeat.net/projects/man-pages/
| >
| > I agree, please let's not clutter the kernel tree.
|
| Oh, I agree also.  I don't think any of the high-res-timers
| support patches belong in the tree.  For testing and
| verifying the system calls, however, it is nice to have
| them.  It is easy to do the patch and then move the whole
| directory as this is the only thing in it.
|
| I might suggest, however, that we should have a regression
| test set for the kernel "somewhere".  Does such a thing
| exist?  I haven't seen it, but then I have yet to see a
| great number of things ;)

I believe that IBM's LTP project does regression testing on
2.5.x kernels.  That's more for things like compile/build and
syscall correctness IIRC.  Not so much as performance (regression)
testing.

-- 
~Randy

