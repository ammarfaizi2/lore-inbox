Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262613AbUCHQc3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 11:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262687AbUCHQc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 11:32:29 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:19100 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S262613AbUCHQc1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 11:32:27 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Tom Rini <trini@kernel.crashing.org>
Subject: Re: kgdb for mainline kernel: core-lite [patch 1/3]
Date: Mon, 8 Mar 2004 22:02:12 +0530
User-Agent: KMail/1.5
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       george@mvista.com, pavel@ucw.cz
References: <200403081504.30840.amitkale@emsyssoft.com> <200403081650.18641.amitkale@emsyssoft.com> <20040308152214.GE15065@smtp.west.cox.net>
In-Reply-To: <20040308152214.GE15065@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403082202.12822.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 Mar 2004 8:52 pm, Tom Rini wrote:
> On Mon, Mar 08, 2004 at 04:50:18PM +0530, Amit S. Kale wrote:
> > On Monday 08 Mar 2004 4:37 pm, Andrew Morton wrote:
> > > "Amit S. Kale" <amitkale@emsyssoft.com> wrote:
>
> [snip]
>
> > > >  If you consider it an absolutely must, we can do something so that
> > > > the dirty part is kept away and info threads almost always works.
> > >
> > > Yes, I'd consider `info threads' support a must-have.  I'm rather
> > > surprised that others do not?
> >
> > Present threads support code changes calling convention of do_IRQ. Most
> > believe that to be an absolute no.
>
> I believe that George's version does something totally different, with
> some macros at compile time (and binutils support, I _think_) to not
> have to change do_IRQ.

OOPS! Present code doesn't change calling convention of do_IRQ. I changed that 
some time ago.

-Amit

