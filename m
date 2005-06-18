Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262217AbVFRSrV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262217AbVFRSrV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 14:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262222AbVFRSrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 14:47:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21917 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262217AbVFRSq5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 14:46:57 -0400
Date: Sat, 18 Jun 2005 11:48:59 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Andrew Morton <akpm@osdl.org>, Netdev List <netdev@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [git patches] 2.6.x net driver updates
In-Reply-To: <42B469B6.2060502@pobox.com>
Message-ID: <Pine.LNX.4.58.0506181146260.2268@ppc970.osdl.org>
References: <42B456E2.8000500@pobox.com> <Pine.LNX.4.58.0506181047190.2268@ppc970.osdl.org>
 <Pine.LNX.4.58.0506181105110.2268@ppc970.osdl.org>
 <Pine.LNX.4.58.0506181112590.2268@ppc970.osdl.org> <42B469B6.2060502@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 18 Jun 2005, Jeff Garzik wrote:
>
> Linus Torvalds wrote:
> > I'm hoping my earlier pulls on your trees haven't resulted in these kinds 
> > of history losses before, and that this was the first time you did a merge 
> > and didn't specify the parents properly. Pls confirm..
> 
> You're being overly paranoid :)
> 
> This netdev-2.6.git episode was the first time I ever tried to use the 
> conflict merging.  I didn't know git had improved to the point where 
> "git commit" without any arguments would actually get things right.
> 
> All the other merges used the vanilla git-pull-script with no 
> modifications.  Presumably it does the right thing :)

Yes.

Ok, I ended up re-doing the merge by hand (ie I fetched all the other 
parts, ignored your top entry, and just merged the previous one manually). 

I'm pushing out the result now, can you verify that the r8192.c file looks
like you expected it to look? I think it should be the same thing you
ended up with except for fixed parents, but...

		Linus
