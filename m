Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317571AbSHCNae>; Sat, 3 Aug 2002 09:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317572AbSHCNad>; Sat, 3 Aug 2002 09:30:33 -0400
Received: from meg.hrz.tu-chemnitz.de ([134.109.132.57]:59400 "EHLO
	meg.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S317571AbSHCNad>; Sat, 3 Aug 2002 09:30:33 -0400
Date: Thu, 1 Aug 2002 20:29:28 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Sam Vilain <sam@vilain.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-rc3 (hyperthreading)
Message-ID: <20020801202928.A5777@nightmaster.csn.tu-chemnitz.de>
References: <Pine.LNX.3.96.1020730230654.6974E-100000@gatekeeper.tmr.com> <Pine.LNX.4.44L.0207310940350.23404-100000@imladris.surriel.com> <20020731141606.093752B65@hofmann>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20020731141606.093752B65@hofmann>; from sam@vilain.net on Wed, Jul 31, 2002 at 03:16:05PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2002 at 03:16:05PM +0100, Sam Vilain wrote:
> the exception of the O(1) scheduler, very nice).  At the very least, I
> think every function should have a comment listing all of its input
> variables and what they mean, along with a rough idea of what the
> function does, and what it returns, along with any assumptions. 

I would like to see at least the identifiers named sanely
(is there already in the Linux kernel) and ALL the assumptions
documented with BUG_ON() or sth. like this.

The rest can be reconstructed by reading the source. But non-local 
assumptions are a nasty source for BUGs :-(

> It would make the code a *lot* easier for programmers with less
> than guru levels of knowledge to understand and hack on.

But it shouldn't be that easy, that Aunt Tillie starts submitting
feature patches without understanding the whole picture ;-)

PS: Trimmed CC a little, since these people are busy doing other
   things.

Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
