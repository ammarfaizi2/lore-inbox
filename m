Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262160AbVFRSH5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262160AbVFRSH5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 14:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262162AbVFRSH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 14:07:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1941 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262160AbVFRRlN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 13:41:13 -0400
Date: Sat, 18 Jun 2005 10:42:50 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
cc: Willy Tarreau <willy@w.ods.org>, Keith Owens <kaos@ocs.com.au>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.12
In-Reply-To: <Pine.LNX.4.62.0506181231410.2653@dragon.hyggekrogen.localhost>
Message-ID: <Pine.LNX.4.58.0506181041460.2268@ppc970.osdl.org>
References: <21446.1119073126@ocs3.ocs.com.au> <Pine.LNX.4.58.0506172255280.2268@ppc970.osdl.org>
 <20050618065911.GH8907@alpha.home.local> <Pine.LNX.4.62.0506181231410.2653@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 18 Jun 2005, Jesper Juhl wrote:
> On Sat, 18 Jun 2005, Willy Tarreau wrote:
> 
> > On Fri, Jun 17, 2005 at 11:05:28PM -0700, Linus Torvalds wrote:
> >  
> > > Because it's extracted as a regular file (instead of tar knowing that it's 
> > > a comment header), you will now have a file called "pax_global_header" 
> > > that has the contents
> > 
> > I guess it will end up in dontdiff quickly :-)
> > 
> If Linus accepts the patch below, then yes :-)

Actually, I won't.

As far as I know, the "pax_global_header" file doesn't get added to inside
the Linux directory, it gets added to the "top" directory, ie one 
directory up from the Linux directory. As such, this should all be 
unnecessary.

		Linus
