Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262901AbSKDCEG>; Sun, 3 Nov 2002 21:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264618AbSKDCEG>; Sun, 3 Nov 2002 21:04:06 -0500
Received: from c3p0.cc.swin.edu.au ([136.186.1.10]:56336 "EHLO
	net.cc.swin.edu.au") by vger.kernel.org with ESMTP
	id <S262901AbSKDCEG>; Sun, 3 Nov 2002 21:04:06 -0500
Date: Mon, 4 Nov 2002 13:10:36 +1100 (EST)
From: Tim Connors <tconnors@astro.swin.edu.au>
To: <linux-kernel@vger.kernel.org>
Subject: small memory machine, large reserved memory
Message-ID: <Pine.LNX.4.33.0211041304010.16003-100000@hexane.ssi.swin.edu.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In light of the recent discussions about config_tiny, etc, I decided to
install 2.4.19 on my old 8MB 486, to see whether it performed any better
than my previous attempts with 2.2.* and 2.4.*

The strange thing is, the memory init line at bootup (eg Memory:
255296k/261996k available (1584k kernel code, 5972k reserved, 1353k data
, 108k init, 0k highmem)) says that only about 5 or 6MB are availabel,
with a whopping 2.x MB reserved. I have done a web search, and the only
answer I have come up with is that the top 384kb of the 1MB lower
portion of RAM should be here, but what else could be eating up all my
RAM?

There is nothgin suspicious in the BIOS - all BIOS and video caching is
turned off. The machine only (natually) has ISA slots in it, most are
empty. What else could possibly be wrong?

Is there something I can hack in the kernel to get it to use that, or can
anyone give me pointers as to what else I can change? I would really love
to regain that 2MB - its a pain when the shell gets swapped out after
doing an `ls` :)

-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/

            Computer screens simply ooze buckets of yang.
    To balance this, place some women around the corners of the room.
                                        -- Kaz Cooke, Dumb Feng Shui

