Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262511AbUCHPWT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 10:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262509AbUCHPWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 10:22:19 -0500
Received: from fed1mtao01.cox.net ([68.6.19.244]:51124 "EHLO
	fed1mtao01.cox.net") by vger.kernel.org with ESMTP id S262511AbUCHPWQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 10:22:16 -0500
Date: Mon, 8 Mar 2004 08:22:14 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       george@mvista.com, pavel@ucw.cz
Subject: Re: kgdb for mainline kernel: core-lite [patch 1/3]
Message-ID: <20040308152214.GE15065@smtp.west.cox.net>
References: <200403081504.30840.amitkale@emsyssoft.com> <200403081619.16771.amitkale@emsyssoft.com> <20040308030722.01948c93.akpm@osdl.org> <200403081650.18641.amitkale@emsyssoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403081650.18641.amitkale@emsyssoft.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2004 at 04:50:18PM +0530, Amit S. Kale wrote:
> On Monday 08 Mar 2004 4:37 pm, Andrew Morton wrote:
> > "Amit S. Kale" <amitkale@emsyssoft.com> wrote:
[snip]
> > >  If you consider it an absolutely must, we can do something so that the
> > > dirty part is kept away and info threads almost always works.
> >
> > Yes, I'd consider `info threads' support a must-have.  I'm rather surprised
> > that others do not?
> 
> Present threads support code changes calling convention of do_IRQ. Most 
> believe that to be an absolute no.

I believe that George's version does something totally different, with
some macros at compile time (and binutils support, I _think_) to not
have to change do_IRQ.

-- 
Tom Rini
http://gate.crashing.org/~trini/
