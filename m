Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261559AbSJHTuk>; Tue, 8 Oct 2002 15:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261526AbSJHTti>; Tue, 8 Oct 2002 15:49:38 -0400
Received: from pdbn-d9bb8651.pool.mediaWays.net ([217.187.134.81]:4616 "EHLO
	citd.de") by vger.kernel.org with ESMTP id <S261523AbSJHTs1>;
	Tue, 8 Oct 2002 15:48:27 -0400
Date: Tue, 8 Oct 2002 21:53:32 +0200
From: Matthias Schniedermeyer <ms@citd.de>
To: Chris Wedgwood <cw@f00f.org>
Cc: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org, akpm@digeo.com,
       riel@conectiva.com.br
Subject: Re: [PATCH] O_STREAMING - flag for optimal streaming I/O
Message-ID: <20021008195332.GA2313@citd.de>
References: <1034044736.29463.318.camel@phantasy> <20021008183824.GA4494@tapu.f00f.org> <1034102950.30670.1433.camel@phantasy> <20021008190513.GA4728@tapu.f00f.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021008190513.GA4728@tapu.f00f.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2002 at 12:05:13PM -0700, Chris Wedgwood wrote:
> Playing the devil's advocate here...  I didn't see this earlier (when
> was it discussed, I can't see it looking back either), so sorry if
> this sounds circular or I'm going over stuff that has been discussed
> before... but...
> 
> 
> On Tue, Oct 08, 2002 at 02:49:09PM -0400, Robert Love wrote:
> 
> > In other words, this flag pretty much disables the pagecache for
> > this mapping, although we happily keep it around for write-behind
> > and read-ahead.  But once the data is behind us and safe to kill, we
> > do.  It is manual drop-behind.
> 
> OK.  What might use this though?  What applications might want to
> disable the page-cache but still use write-behind?

mkisofs?

Or do you have a machine with 5-6 GB of RAM to cache the content of a
DVD-image?
I only have 3 GB of RAM, and creating and writing trashes the whole
cache twice.





Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as 
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated, 
cryptic, powerful, unforgiving, dangerous.

