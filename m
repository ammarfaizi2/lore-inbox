Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293135AbSDYGVE>; Thu, 25 Apr 2002 02:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312939AbSDYGVD>; Thu, 25 Apr 2002 02:21:03 -0400
Received: from air-2.osdl.org ([65.201.151.6]:52490 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S293135AbSDYGVC>;
	Thu, 25 Apr 2002 02:21:02 -0400
Date: Wed, 24 Apr 2002 23:15:32 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Chris Caputo <ccaputo@alt.net>
cc: Ben Greear <greearb@candelatech.com>, <linux-kernel@vger.kernel.org>
Subject: Re: unresolved symbol: __udivdi3
In-Reply-To: <Pine.LNX.4.44.0204201144510.4529-100000@nacho.alt.net>
Message-ID: <Pine.LNX.4.33L2.0204242313480.8788-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I threw that function into a little procfs test module
that I have and it worked nicely.  Thanks.

~Randy

On Sat, 20 Apr 2002, Chris Caputo wrote:

| On Fri, 19 Apr 2002, Ben Greear wrote:
| > Also, for what it's worth, do_div on x86 seems to corrupt arguments
| > given to it, and may do other screwy things.  I'm just going to
| > go back to casting and let user-space do any precise division.
|
| Or consider the code from:
|
|  http://nemesis.sourceforge.net/browse/lib/static/intmath/ix86/intmath.c.html
|
| Adapted as follows...
|
| Chris
|
| ---
|
| // Function copied/adapted/optimized from:
| //
| //  nemesis.sourceforge.net/browse/lib/static/intmath/ix86/intmath.c.html
| //
| // Copyright 1994, University of Cambridge Computer Laboratory
| // All Rights Reserved.
| //
| // TODO: When running on a 64-bit CPU platform, this should no longer be
| // TODO: necessary.
| -

