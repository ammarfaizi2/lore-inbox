Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316600AbSFGBpd>; Thu, 6 Jun 2002 21:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316601AbSFGBpc>; Thu, 6 Jun 2002 21:45:32 -0400
Received: from mark.mielke.cc ([216.209.85.42]:56327 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S316600AbSFGBpc>;
	Thu, 6 Jun 2002 21:45:32 -0400
Date: Thu, 6 Jun 2002 21:39:35 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Cc: Kai Henningsen <kaih@khms.westfalen.de>, linux-kernel@vger.kernel.org
Subject: Re: If you want kbuild 2.5, tell Linus
Message-ID: <20020606213935.B3551@mark.mielke.cc>
In-Reply-To: <200206062101.QAA15457@tomcat.admin.navo.hpc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2002 at 04:01:27PM -0500, Jesse Pollard wrote:
> kaih@khms.westfalen.de (Kai Henningsen):
> > Frankly, I see *absolutely no way* how the current Kai-Linus "merge" can  
> > possibly end with something even remotely like Keith's kbuild2.5. Unless  
> > Linus changes his approach radically.
> > If I were Keith, I'd be rather upset, too.
> How about the following approach, which MAY not be practical:
> 1. Name all of the new Makefiles Makefile.k2.5
> 2. Create a small wrapper script to define make as "make -f Makefile.k2.5"
>    or just define MAKE as make -f Makefile.k2.5 in the top level
>    Makefile.k2.5

I think if you had read their posts more thoroughly, or checked the patch
out yourself, you would have found that they already did this.

kbuild2.5 and kbuild2.4 are already made to exist side by side.

I dunno about the Linus-wall thing though. I think Linus has good reasons
that apply in the general case, but probably don't apply at all for this
specific case.

How do you make an exception without allowing for exceptions?

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

