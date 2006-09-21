Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751207AbWIUP02@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbWIUP02 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 11:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbWIUP02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 11:26:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16810 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751207AbWIUP01 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 11:26:27 -0400
Date: Thu, 21 Sep 2006 08:25:55 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.19 -mm merge plans
In-Reply-To: <1158830206.11109.84.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0609210819170.4388@g5.osdl.org>
References: <20060920135438.d7dd362b.akpm@osdl.org>  <45121382.1090403@garzik.org>
  <20060920220744.0427539d.akpm@osdl.org> <1158830206.11109.84.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 21 Sep 2006, Alan Cox wrote:
> 
> A suggestion from the department of evil ideas: Call even cycles
> development odd ones stabilizing. Nothing gets into an odd one without a
> review and linux-kernel signoff/ack ?

I don't think that's an evil idea, and in fact we've discussed it before. 
I personally like it - right now we tend to have that "interminable series 
of -rc<n>" (where <n> is 3..) before release, and I'd almost personally 
prefer to just have a rule that is more along the lines of

 - 2.6.<odd> is "the big initial merges with all the obvious fixes to make 
   it all work" (ie roughly the current -rc2 or perhaps -rc3).

 - 2.6.<even> is "no big merges, just careful fixes" (ie the current "real 
   release")

Each would be ~3 weeks, leaving us with effectively the same real release 
schedule, just a naming change.

That said, I think Andrew was of the opinion that it doesn't really _fix_ 
anything, and he may well be right. What's the point of the odd release, 
if the weekly snapshots after that are supposed to be strictly better than 
it anyway?

So I think I may like it just because it _seems_ to combine the good 
features of both the old naming scheme and the current one, but I suspect 
Andrew may be right in that it doesn't _really_ change anything, deep 
down.

Dunno.

			Linus
