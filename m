Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264666AbSLRQeP>; Wed, 18 Dec 2002 11:34:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264679AbSLRQeO>; Wed, 18 Dec 2002 11:34:14 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:30363 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S264666AbSLRQeN>;
	Wed, 18 Dec 2002 11:34:13 -0500
Date: Wed, 18 Dec 2002 16:41:19 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
Message-ID: <20021218164119.GC27695@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Horst von Brand <vonbrand@inf.utfsm.cl>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <torvalds@transmeta.com> <Pine.LNX.4.44.0212171716020.1362-100000@home.transmeta.com> <200212181340.gBIDeOmK018730@pincoya.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212181340.gBIDeOmK018730@pincoya.inf.utfsm.cl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2002 at 10:40:24AM -0300, Horst von Brand wrote:
 > [Extremely interesting new syscall mechanism tread elided]
 > 
 > What happened to "feature freeze"?

*bites lip* it's fairly low impact *duck*.
Given the wins seem to be fairly impressive across the board, spending
a few days on getting this right isn't going to push 2.6 back any
noticable amount of time.

This stuff is mostly of the case "it either works, or it doesn't".
And right now, corner cases like apm aside, it seems to be holding up
so far. This isn't as far reaching as it sounds. There are still
drivers being turned upside down which are changing things in a
lot bigger ways than this[1]

		Dave

[1] Myself being one of the guilty parties there, wrt agp.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
