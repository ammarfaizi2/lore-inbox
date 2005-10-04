Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964842AbVJDQRM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbVJDQRM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 12:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964846AbVJDQRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 12:17:12 -0400
Received: from free.hands.com ([83.142.228.128]:23436 "EHLO free.hands.com")
	by vger.kernel.org with ESMTP id S964842AbVJDQRL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 12:17:11 -0400
Date: Tue, 4 Oct 2005 17:17:02 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Nikita Danilov <nikita@clusterfs.com>
Cc: "Martin J. Bligh" <mbligh@mbligh.org>, Rik van Riel <riel@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
Message-ID: <20051004161702.GU10538@lkcl.net>
References: <20051002204703.GG6290@lkcl.net> <54300000.1128297891@[10.10.2.4]> <20051003011041.GN6290@lkcl.net> <200510022028.07930.chase.venters@clientec.com> <20051004125955.GQ10538@lkcl.net> <17218.39427.421249.448094@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17218.39427.421249.448094@gargle.gargle.HOWL>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2005 at 07:04:35PM +0400, Nikita Danilov wrote:
> Luke Kenneth Casson Leighton writes:
>  > On Sun, Oct 02, 2005 at 08:27:45PM -0500, Chase Venters wrote:
>  > 
>  > > The bottom line is that the application developers need to start being clever 
>  > > with threads. 
>  > 
>  >  yep!  ah.  but.  see this:
>  > 
>  >  http://lists.samba.org/archive/samba-technical/2004-December/038300.html
>  > 
>  >  and think what would happen if glibc had hardware-support for
>  >  semaphores and mutexes.
> 
> Let me guess... nothing? 

 interesting.

> Overhead of locking depends on data-structures
> used by application/library and their access patterns: one thread has to
> wait for another to finish with the shared resource.

 yes.

> locking in hardware is going to change nothing here (barring really
> stupid implementations of locking primitives). Especially as we are
> talking about blocking primitives, like pthread semaphore or mutex: an
> entry into the scheduler will by far outweigh any advantages of
> raw-metal synchronization.
 
 so what would, in your opinion, be a good optimisation?
 
 the references i found (just below) are to tool chains or research
 projects for code or linker-level analysis and parallelisation tools.

 what would, in your opinion, be a good way for hardware to assist
 thread optimisation, at this level (glibc)?

 assuming that you have an intelligent programmer (or some really good
 and working parallelisation tools) who really knows his threads?



>  >  http://www.ics.ele.tue.nl/~sander/publications.php
>  >  http://portal.acm.org/citation.cfm?id=582068
>  >  http://csdl.computer.org/comp/proceedings/acsd/2003/1887/00/18870237.pdf
>  > 
>  >  to get the above references, put in "holland parallel code
>  >  analysis tools" into google.com.
> 
> PS: I wonder why Luke Kenneth Casson Leighton, Esq., while failing to

 can i invite you to consider, when replying to these lists, to consider
 instead of treating it as a location where you can piss over anyone
 that you do not believe to be in any way your equal or in fact the equal
 of anyone, to instead consider the following template for your replies:

 	okay, right.
	* i do/don't get what this guy is saying.
	* i do/don't have an alternative idea (here it is / sorry)
	* here's what's wrong / right with what he's saying.
	* here's where it can/can't be done better.

 the bits that are missing from your reply are:
 
 * "you do/don't get where i'm going with this"
 * you haven't specified an alternative idea
 * you've outlined what's wrong but not what's right
 * you haven't specified how it can be done better.

 i therefore conclude that you are bully.  a snob.

 i _really_ detest bullying - and that's what you are doing.

 intellectual bullying.

 stop it.

 so i sent some messages saying "i think the kernel developers could be
 wrong in their design strategy" so FRIGGIN what?

 prove me right or prove me wrong.

 or shut up, or add my email address to your killfile.

 _don't_ be an intellectual snob.

 l.

