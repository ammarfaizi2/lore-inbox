Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261698AbUKIV0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261698AbUKIV0O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 16:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbUKIV0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 16:26:14 -0500
Received: from ozlabs.org ([203.10.76.45]:41691 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261698AbUKIV0D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 16:26:03 -0500
Date: Wed, 10 Nov 2004 08:20:47 +1100
From: Anton Blanchard <anton@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ppc64: Bump MAX_HWIFS in IDE code
Message-ID: <20041109212047.GB26806@krispykreme.ozlabs.ibm.com>
References: <20041109203028.GA26806@krispykreme.ozlabs.ibm.com> <20041109125507.4bc49b3c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041109125507.4bc49b3c.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > diff -puN include/asm-ppc64/ide.h~bump_ide_hwifs include/asm-ppc64/ide.h
> > --- gr_work/include/asm-ppc64/ide.h~bump_ide_hwifs	2004-08-25 08:11:54.357759525 -0500
> > +++ gr_work-anton/include/asm-ppc64/ide.h	2004-08-25 08:11:54.366758100 -0500
> > @@ -19,7 +19,7 @@
> >  #ifdef __KERNEL__
> >  
> >  #ifndef MAX_HWIFS
> > -# define MAX_HWIFS	4
> > +# define MAX_HWIFS	16
> >  #endif
> 
> hrmph.  That costs 50kbytes, excluding ide-tape.  It's worth a config
> variable, I think.

Ouch. BTW i386 has it set to 10, it should be looked at as well.

Anton
