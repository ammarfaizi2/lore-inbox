Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319258AbSHWTuc>; Fri, 23 Aug 2002 15:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319242AbSHWTtj>; Fri, 23 Aug 2002 15:49:39 -0400
Received: from [195.39.17.254] ([195.39.17.254]:25216 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S319258AbSHWTtT>;
	Fri, 23 Aug 2002 15:49:19 -0400
Date: Fri, 2 Nov 2001 10:34:27 +0000
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Oliver Xymoron <oxymoron@waste.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
Message-ID: <20011102103427.Z35@toy.ucw.cz>
References: <20020818052417.GL21643@waste.org> <Pine.LNX.4.44.0208180916560.10546-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.44.0208180916560.10546-100000@home.transmeta.com>; from torvalds@transmeta.com on Sun, Aug 18, 2002 at 09:59:41AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> And your argument that there is zero randomness in the TSC _depends_ on
> your ability to perfectly estimate what the TSC is. If you cannot do it,
> there is obviously at least one bit of randomness there. So I don't think
> your "zero" is a good conservative estimate.

Actually, no. If something is not predictable it does not mean >= 1 bit.

There is < half of bit of information in "this human is older than 100 years".

There's about 7.3 bits per word in english sentence. Etc, fractional bits
exist.
									Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

