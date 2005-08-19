Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbVHTXjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbVHTXjp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 19:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbVHTXjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 19:39:45 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:32963 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1750724AbVHTXjp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 19:39:45 -0400
Message-Id: <200508191304.j7JD4utA010195@laptop11.inf.utfsm.cl>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Andrew Morton <akpm@osdl.org>, davem@davemloft.net, riel@redhat.com,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFT 4/5] CLOCK-Pro page replacement 
In-Reply-To: Message from Rusty Russell <rusty@rustcorp.com.au> 
   of "Fri, 19 Aug 2005 17:27:06 +1000." <1124436426.23757.5.camel@localhost.localdomain> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Fri, 19 Aug 2005 09:04:56 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell <rusty@rustcorp.com.au> wrote:
> On Fri, 2005-08-19 at 00:10 -0700, Andrew Morton wrote:
> > Rusty Russell <rusty@rustcorp.com.au> wrote:
> > > I believe we just ignored sparc64.  That usually works for solving these
> > > kind of bugs. 8)
> > 
> > heh.  iirc, it was demonstrable on x86 also.
> 
> No.  gcc-2.95 on Sparc64 put uninititialized vars into the bss, ignoring
> the __attribute__((section(".data.percpu"))) directive.  x86 certainly
> doesn't have this, I just tested it w/2.95.
> 
> Really, it's Sparc64 + gcc-2.95.  Send an urgent telegram to the user
> telling them to upgrade.

I recently asked if gcc-2.95 was really still supported, and was told that
it is in common use for its speed...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
