Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262434AbTJTIbl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 04:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262440AbTJTIbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 04:31:41 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:64899 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S262434AbTJTIbj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 04:31:39 -0400
Date: Mon, 20 Oct 2003 10:31:35 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Rob Landley <rob@landley.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Where's the bzip2 compressed linux-kernel patch?
Message-ID: <20031020083135.GB14519@wohnheim.fh-wedel.de>
References: <200310180018.21818.rob@landley.net> <20031018164337.GB11066@wohnheim.fh-wedel.de> <200310181538.35301.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200310181538.35301.rob@landley.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 October 2003 15:38:35 -0500, Rob Landley wrote:
> 
> The decompression-side ones, yes.  (Modulo different command line arguments, 
> and that I didn't implement the "small mode" that's slower but uses less 
> memory.  That would probably only add a couple hundred bytes, and I could 
> make it a compile time option, but I just haven't gotten around to it yet.  
> If somebody wants to send me a patch... :)

Does anyone really need the "small mode"?  If not, I consider it a
feature to not support it. :)

> > Not pretty with 80 columns, but it looks good at first glance.
> 
> Manuel Novoa submitted a patch that sped things up over 10% (seriously cool, 
> that's why we're faster than the original), but broke the 80 column thing 
> (mostly a couple return statements that need to be on the next line).
> 
> I'm happy to take a patch to clean it up. :)

Today is rainy.  Why not? ;)

> > And surely more fun to work on than the zlib-inspired code from Julian.
> 
> That was the original reason for doing this, yes. :)

You don't - by any chance - plan the same thing for the compression
side, do you?  I still have vague plans to improve the algorithm a bit,
so a clean codebase would be nice to have.

> Eric Anderson pointed me to the new home of the kernel bunzip patch, which is 
> at "http://shepard.kicks-ass.net/~cc/", and I'll take a stab at porting it to 
> 2.6.0-test8 as the mood strikes me. :)

Cool!  Maybe I should update my patches again.  They are definitely
2.7 material, but if people want to play with that stuff...

Jörn

-- 
My second remark is that our intellectual powers are rather geared to
master static relations and that our powers to visualize processes
evolving in time are relatively poorly developed.
-- Edsger W. Dijkstra
