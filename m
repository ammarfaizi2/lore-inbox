Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751101AbWHGGUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbWHGGUV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 02:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbWHGGUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 02:20:21 -0400
Received: from cantor2.suse.de ([195.135.220.15]:59289 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751101AbWHGGUT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 02:20:19 -0400
From: Andi Kleen <ak@muc.de>
To: virtualization@lists.osdl.org
Subject: Re: [PATCH 1/4] x86 paravirt_ops: create no_paravirt.h for native ops
Date: Mon, 7 Aug 2006 08:17:42 +0200
User-Agent: KMail/1.9.3
Cc: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@sous-sol.org>
References: <1154925835.21647.29.camel@localhost.localdomain> <200608070730.17813.ak@muc.de> <1154930669.7642.12.camel@localhost.localdomain>
In-Reply-To: <1154930669.7642.12.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608070817.42074.ak@muc.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 August 2006 08:04, Rusty Russell wrote:
> On Mon, 2006-08-07 at 07:30 +0200, Andi Kleen wrote:
> > > ===================================================================
> > > --- /dev/null
> > > +++ b/include/asm-i386/no_paravirt.h
> > 
> > I can't say I like the name. After all that should be the normal
> > case for a long time now ... native? normal? bareiron?
> 
> Yeah, I don't like it much either.  native.h doesn't say what the
> alternative is.  native_paravirt.h is kind of contradictory.

You could create a subdirectory?

> I'm just shuffling code here, and if the other approach works, I won't
> even be doing that.

If you move it you can as well clean it up.  The result would be likely
at least 50% shorter.

-Andi
