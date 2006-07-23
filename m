Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751284AbWGWTrD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbWGWTrD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 15:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbWGWTrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 15:47:03 -0400
Received: from gepetto.dc.ltu.se ([130.240.42.40]:1000 "EHLO gepetto.dc.ltu.se")
	by vger.kernel.org with ESMTP id S1751284AbWGWTrC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 15:47:02 -0400
Message-ID: <1153683996.44c3d21c430b5@portal.student.luth.se>
Date: Sun, 23 Jul 2006 21:46:36 +0200
From: ricknu-0@student.ltu.se
To: Michael Buesch <mb@bu3sch.de>
Cc: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>,
       Alexey Dobriyan <adobriyan@gmail.com>,
       Vadim Lobanov <vlobanov@speakeasy.net>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Shorty Porty <getshorty_@hotmail.com>,
       Peter Williams <pwil3058@bigpond.net.au>,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>, larsbj@gullik.net,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] A generic boolean (version 4)
References: <1153341500.44be983ca1407@portal.student.luth.se> <1153669750.44c39a7607a30@portal.student.luth.se> <200607231813.21813.mb@bu3sch.de>
In-Reply-To: <200607231813.21813.mb@bu3sch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
X-Originating-IP: 130.240.42.170
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Citerar Michael Buesch <mb@bu3sch.de>:

> On Sunday 23 July 2006 17:49, ricknu-0@student.ltu.se wrote:
> > And here comes lucky number four.
> 
> > diff --git a/include/asm-i386/types.h b/include/asm-i386/types.h
> > index 4b4b295..3cb84ac 100644
> > --- a/include/asm-i386/types.h
> > +++ b/include/asm-i386/types.h
> > @@ -1,6 +1,8 @@
> >  #ifndef _I386_TYPES_H
> >  #define _I386_TYPES_H
> >  
> > +typedef _Bool bool;
> > +
> >  #ifndef __ASSEMBLY__
> 
> I'd say that typedef must go into the !__ASSEMBLY__ section here,
> like the other typedefs in that header.

You are right. Misstook the #endif as #else (a downside of programming late).
It is corrected, thanks.

> Greetings Michael.

See ya
/Richard
