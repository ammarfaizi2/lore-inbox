Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267505AbUH0UOj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267505AbUH0UOj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 16:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267576AbUH0UNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 16:13:32 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:49871 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S267514AbUH0UGr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 16:06:47 -0400
Message-Id: <200408261817.i7QIH35O002702@localhost.localdomain>
To: Helge Hafting <helge.hafting@hist.no>
cc: Matt Mackall <mpm@selenic.com>, Nicholas Miell <nmiell@gmail.com>,
       Wichert Akkerman <wichert@wiggy.net>, Jeremy Allison <jra@samba.org>,
       Andrew Morton <akpm@osdl.org>, Spam <spam@tnonline.net>,
       torvalds@osdl.org, reiser@namesys.com, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4 
In-Reply-To: Message from Helge Hafting <helge.hafting@hist.no> 
   of "Thu, 26 Aug 2004 10:31:54 +0200." <412D9FFA.6030307@hist.no> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Thu, 26 Aug 2004 14:17:03 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting <helge.hafting@hist.no> said:
> Matt Mackall wrote:

[...]

> >Find some silly person with an iBook and open a shell on OS X. Use cp
> >to copy a file with a resource fork. Oh look, the Finder has no idea
> >what the new file is, even though it looks exactly identical in the
> >shell. Isn't that _wonderful_? 

> It is what I'd expect.

Great. That means that all the tools of the trade stop working. Sounds like
show-killer feature to me.

>                         Now, use cp -R to copy  the file
> _with its directory_,

Either it is a file or a directory. Make up your mind. If you have no clear
distinction, you'll only get messed up. Badly.

>                       and see if that fares better.  If not - bad
> implementation of fs and/or cp.  The way I see file-as -directory
> is that _file_ operations (like the reads issued by cat) only
> work on the file part.  You want the directory part?  Use
> directory operations such as those "cp -R" use.

Excuse me, I must grab my sickness bag here.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
