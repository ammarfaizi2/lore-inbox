Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317022AbSH0V01>; Tue, 27 Aug 2002 17:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317107AbSH0V01>; Tue, 27 Aug 2002 17:26:27 -0400
Received: from [195.223.140.120] ([195.223.140.120]:3963 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S317022AbSH0V00>; Tue, 27 Aug 2002 17:26:26 -0400
Date: Tue, 27 Aug 2002 23:32:06 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Luca Barbieri <ldb@ldb.ods.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, Hugh Dickins <hugh@veritas.com>,
       Dave Jones <davej@suse.de>,
       Marc Dietrich <Marc.Dietrich@hrz.uni-giessen.de>,
       Linux-Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] M386 flush_one_tlb invlpg
Message-ID: <20020827213206.GV25092@dualathlon.random>
References: <Pine.LNX.4.44.0208271216440.1419-100000@home.transmeta.com> <1030481129.6203.3.camel@ldb>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1030481129.6203.3.camel@ldb>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2002 at 10:45:29PM +0200, Luca Barbieri wrote:
> You haven't read the P4 system architecture manual, section 3.11.
> It explicitly says that invlpg ignores the G flag.

btw, we just depend on it for example on every kmap_atomic.

Andrea
