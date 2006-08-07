Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750866AbWHGG1L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866AbWHGG1L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 02:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750889AbWHGG1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 02:27:11 -0400
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:55850 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1750866AbWHGG1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 02:27:10 -0400
Date: Mon, 7 Aug 2006 09:27:05 +0300
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Andi Kleen <ak@muc.de>
Cc: virtualization@lists.osdl.org, Rusty Russell <rusty@rustcorp.com.au>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH 1/4] x86 paravirt_ops: create no_paravirt.h for native ops
Message-ID: <20060807062705.GB4979@rhun.haifa.ibm.com>
References: <1154925835.21647.29.camel@localhost.localdomain> <200608070730.17813.ak@muc.de> <1154930669.7642.12.camel@localhost.localdomain> <200608070817.42074.ak@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608070817.42074.ak@muc.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Monday 07 August 2006 08:04, Rusty Russell wrote:
> > On Mon, 2006-08-07 at 07:30 +0200, Andi Kleen wrote:
> > > > ===================================================================
> > > > --- /dev/null
> > > > +++ b/include/asm-i386/no_paravirt.h
> > > 
> > > I can't say I like the name. After all that should be the normal
> > > case for a long time now ... native? normal? bareiron?
> > 
> > Yeah, I don't like it much either.  native.h doesn't say what the
> > alternative is.  native_paravirt.h is kind of contradictory.

baremetal.h seems appropriate.

Cheers,
Muli
