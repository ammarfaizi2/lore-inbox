Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263107AbUFRVjH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263107AbUFRVjH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 17:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264531AbUFRVhk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 17:37:40 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:13241 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S263107AbUFRVdn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 17:33:43 -0400
Date: Fri, 18 Jun 2004 23:33:38 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cross-sparse
Message-ID: <20040618213338.GA4975@MAIL.13thfloor.at>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/m68k <linux-m68k@lists.linux-m68k.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <Pine.GSO.4.58.0406172304170.1495@waterleaf.sonytel.be> <Pine.LNX.4.58.0406180925210.4669@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0406180925210.4669@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2004 at 09:27:22AM -0700, Linus Torvalds wrote:
> On Thu, 17 Jun 2004, Geert Uytterhoeven wrote:
> > 
> > I wanted to give sparse a try on m68k, and noticed the current 
> > infrastructure doesn't handle cross-compilation (no sane m68k 
> > people compile kernels natively anymore, unless they run a 
> > Debian autobuilder ;-).
> > 
> > After hacking the include paths in the sparse sources, installing 
> > the resulting binary as m68k-linux-sparse, and applying the 
> > following patch, it seems to work fine!
> 
> Hmm.. It does make sense, but at the same time, sparse isn't even really 
> supposed to _care_ about the architecture. Especially not for a kernel 
> build.

apologies for assasinating this thread ...

I did an 'extensive' search with google (you do not want 
to know how many hits you get with 'sparse') and read 
most postings on the sparse mailinglist (linux-sparse),
found the freshmeat project pointing me to the 'new url'
http://www.codemonkey.org.uk/projects/sparse/ where I can
download 'sparse-2003-11-27.tar.gz', then found out that
there should be a maintained (up to date) version of it at 

   http://www.kernel.org/pub/software/devel/sparse/

but what I find there, seems of no use to me ...
(I'm no bitkeeper person) so I'm still looking for an url
where I can get a recent .tar to install that beast.

can anybody point me in the right direction, please?

TIA,
Herbert

> Which part breaks when not just using the native sparse? As far as I know, 
> a kernel build should use all-kernel header files, with the exception of 
> "stdarg.h" which I thought was also architecture-independent (but hey, 
> maybe I'm just a retard, and am wrong).
> 
> 		Linus
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
