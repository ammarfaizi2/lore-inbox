Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262598AbREOBZ0>; Mon, 14 May 2001 21:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262597AbREOBZG>; Mon, 14 May 2001 21:25:06 -0400
Received: from D8FA50AA.ptr.dia.nextlink.net ([216.250.80.170]:61434 "EHLO
	tetsuo.applianceware.com") by vger.kernel.org with ESMTP
	id <S262598AbREOBZD>; Mon, 14 May 2001 21:25:03 -0400
Date: Mon, 14 May 2001 18:20:58 -0700
From: Mike Panetta <mpanetta@applianceware.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.4 + LFS what am I doing wrong?
Message-ID: <20010514182058.A28482@tetsuo.applianceware.com>
Mail-Followup-To: Mike Panetta <mpanetta@applianceware.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
User-Agent: Mutt/1.2.5i
Organization: ApplianceWare
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I cannot for the life of me get LFS working.
I have recompiled the glibc rpm (the 2.2.1 one)
for i686 and installed it.  I have recompiled
fileutils against that glibc.  It still tells
me that the file is too large when I do a
dd if=/dev/zero of=bigfile bs=8192
it stops at 2.0GB (ls -lh).  What am
I missing?  I thought I had all the pieces
in place.  It works on another machine I
have.  I just don't understand why it does
not work on this one...  I have this gut feeling
its something really stupid but for the life
of me I cannot find out what.


Thanks,
Mike
