Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136647AbREGTon>; Mon, 7 May 2001 15:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136649AbREGToc>; Mon, 7 May 2001 15:44:32 -0400
Received: from bitmover.com ([207.181.251.162]:338 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S136647AbREGToY>;
	Mon, 7 May 2001 15:44:24 -0400
Date: Mon, 7 May 2001 12:44:22 -0700
From: Larry McVoy <lm@bitmover.com>
To: "H. Peter Anvin" <hpa@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Wow! Is memory ever cheap!
Message-ID: <20010507124422.A19774@work.bitmover.com>
Mail-Followup-To: "H. Peter Anvin" <hpa@transmeta.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010505095802.X12431@work.bitmover.com> <20010506142043.B31269@metastasis.f00f.org> <20010505194536.D14127@work.bitmover.com> <9d6qk6$i86$1@cesium.transmeta.com> <20010507115659.T14127@work.bitmover.com> <3AF6F11E.3A03050E@transmeta.com> <20010507121822.V14127@work.bitmover.com> <3AF6F5B8.42F803C1@transmeta.com> <20010507122730.A19632@work.bitmover.com> <3AF6F8A5.F556DF62@transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3i
In-Reply-To: <3AF6F8A5.F556DF62@transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2001 at 12:33:57PM -0700, H. Peter Anvin wrote:
> Larry McVoy wrote:
> > > Because your original post was "yeah, Bitkeeper is a memory hog but you
> > > can get really cheap non-ECC RAM so just stuff your system with crappy
> > > RAM and be happy."  

> I wasn't the one who said it, you did.  I don't have any evidence either
> way.

Err, Peter, it's starting to sound like you have some ax to grind that I
don't know about.  So I'll bow out of this conversation.

For the record, however, I never stated that BitKeeper is a memory hog,
that's a conclusion you drew.  Somehow, if I had said "look, for very
little money you can fit all of the kernel source, revision history,
and objects in memory", would you have translated that into "BitKeeper
is a memory hog"?  It seems that way.  

BitKeeper has nothing to do with it, it's all about how big the data
set is that the application is working on.  BitKeeper is better than
most applications, it mmaps the data and uses the page cache so that it
doesn't cache it twice.  Contrast that with most other apps, you'll see
they have their own internal cache of data when they should just use mmap.

Anyway, I think we've beaten this to death, so let's move on.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
