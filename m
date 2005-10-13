Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbVJMRqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbVJMRqu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 13:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbVJMRqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 13:46:50 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:35794 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932141AbVJMRqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 13:46:49 -0400
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: "Michael Kerrisk" <mtk-manpages@gmx.net>
Subject: Re: man-pages-2.08 is released
Date: Thu, 13 Oct 2005 10:46:44 -0700
User-Agent: KMail/1.8.91
Cc: linux-kernel@vger.kernel.org, michael.kerrisk@gmx.net,
       Andries.Brouwer@cwi.nl
References: <200510121010.16274.jbarnes@virtuousgeek.org> <20785.1129193533@www73.gmx.net>
In-Reply-To: <20785.1129193533@www73.gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510131046.44520.jbarnes@virtuousgeek.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, October 13, 2005 1:52 am, Michael Kerrisk wrote:
> Recently, I was just wondering the same thing.  However, there
> are complexities to consider.  C libraries (okay, glibc is the
> main one I concern myself with) sometimes add some functionality
> in the wrapper function for a particular system call.  This also
> needs to be documented in the Secion 2 page.

True.  But there are other libcs available (e.g. klibc, dietlibc) too.  
I'd think that if the pages were bundled with the kernel, they should 
describe exactly what the kernel does, while pages bundled with a libc 
would describe any enhancements (or breakages) that the particular libc 
includes.  But then what to do about duplicates?  Or should the raw 
kernel interfaces have their own section, while libc interfaces remain 
in section 2?  Or should the libc versions typically replace the kernel 
versions on running systems?  Or 'patch' the existing kernel pages 
somehow?  So many questions... ;)

> Nevertheless, I think the idea of binding the kernel sources and
> Sections 2 and 4 of the manual pages a bit more tightly bears
> some consideration.  In the ideal world, when a change is made to
> the kernel, the patch could include adjustments to the man
> pages (if relevant) -- then the changes could follow the patch
> through the -mm tree and then into Linus's tree.

That was my though too; it's certainly easier to ask people to update 
manual pages in Documentation/ or man/ when they do a kernel patch than 
to ask them to download a separate package and make the changes (since 
they'll probably never get around to doing the latter :).

> > OTOH, they comprise a fairly large package, so adding them to the
> > kernel tarball would increase its size a lot.
>
> I'd guess that the uncompressed source of the relevant pages
> would be around 3 MB.

Ok, that's not too bad.  Having full, up-to-date man pages would be worth 
the extra few megs to me at least.

> > The man pages are great;
>
> Thanks.  But the greatest part of credit must go to Andries,
> the maintainer for nearly 10 years.  I'm shortly coming up to my
> first anniversary...

Many thanks to both of you then!

Jesse
