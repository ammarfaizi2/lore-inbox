Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268088AbTAIW53>; Thu, 9 Jan 2003 17:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268089AbTAIW53>; Thu, 9 Jan 2003 17:57:29 -0500
Received: from waste.org ([209.173.204.2]:50411 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S268088AbTAIW52>;
	Thu, 9 Jan 2003 17:57:28 -0500
Date: Thu, 9 Jan 2003 17:06:05 -0600
From: Oliver Xymoron <oxymoron@waste.org>
To: Andrew Morton <akpm@digeo.com>
Cc: rms@gnu.org, linux-kernel@vger.kernel.org
Subject: Re: Gauntlet Set NOW!
Message-ID: <20030109230605.GB14778@waste.org>
References: <Pine.LNX.4.10.10301031425590.421-100000@master.linux-ide.org> <E18WX7P-0001cV-00@fencepost.gnu.org> <3E1D2E12.27417587@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E1D2E12.27417587@digeo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2003 at 12:08:50AM -0800, Andrew Morton wrote:
> Richard Stallman wrote:
> > 
> > ...
> > That's not the FSF's view.  Our view is that just using structure
> > definitions, typedefs, enumeration constants, macros with simple
> > bodies, etc., is NOT enough to make a derivative work.  It would take
> > a substantial amount of code (coming from inline functions or macros
> > with substantial bodies) to do that.
> 
> The last part doesn't make a lot of sense.
> 
> Use of an inline function is just that: usage.  It matters not at
> all whether that function is invoked via inline integration or via
> subroutine call.  This is merely an implementation detail within
> the code which provides that function.
> 
> Such functions are part of the offered API which have global scope,
> that's all.

I think part of the problem is that 'derived work' here is not
something the FSF or the GPL is really in a position to define. It is
instead the other side of the 'fair use' coin of copyright law. The
question is really how much use of header files is fair use (and
therefore completely independent of copyright) and how much
constitutes a derived work (and therefore subject to the rules of the
GPL)? Only a court can decide.

However, I suspect that 'function' is not a bright line here. There
are certainly plenty of inline functions that are trivial. You can
quote f(x)=x^2 from a paper and not be infringing. Similarly,
most if not all structure definitions are also trivial in the sense
that they're simply lists of names and types - you can copy ingredient
lists, phone directories and the like wholesale and also not be
infringing. You're much more likely to get into trouble with things
like the spinlock or semaphore code which are complex, original, and
fairly unique.

(I first typed that as uniq - enough shell hacking for today)

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
