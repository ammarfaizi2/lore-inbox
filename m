Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262987AbTCLIG7>; Wed, 12 Mar 2003 03:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263023AbTCLIG7>; Wed, 12 Mar 2003 03:06:59 -0500
Received: from are.twiddle.net ([64.81.246.98]:18354 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S262987AbTCLIG6>;
	Wed, 12 Mar 2003 03:06:58 -0500
Date: Wed, 12 Mar 2003 00:17:39 -0800
From: Richard Henderson <rth@twiddle.net>
To: Szakacsits Szabolcs <szaka@sienet.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.63 accesses below %esp (was: Re: ntfs OOPS (2.5.63))
Message-ID: <20030312001739.B30855@twiddle.net>
Mail-Followup-To: Szakacsits Szabolcs <szaka@sienet.hu>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <20030311235223.A30856@twiddle.net> <Pine.LNX.4.30.0303120848040.17121-100000@divine.city.tvnet.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.30.0303120848040.17121-100000@divine.city.tvnet.hu>; from szaka@sienet.hu on Wed, Mar 12, 2003 at 09:02:08AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 12, 2003 at 09:02:08AM +0100, Szakacsits Szabolcs wrote:
> gcc team must have, haven't it? Do you know?

I have one test case.  It was never turned into anything
that you could run.

> I thought about it, I'm just afraid too much kernel wouldn't build.

Then it won't build.  Use a different compiler.

> This bug is in most 2.95, 2.96 and according to Alan in 3.0 and early
> 3.1) and people would just start "working around" it by commenting out
> the check for getting something to work quickly then forgetting about
> the issue completely.

The bug report I can find, 

   http://gcc.gnu.org/ml/gcc-patches/2001-06/msg00746.html

was fixed before gcc 3.0.0 was released.  So if this is
a different bug...


r~
