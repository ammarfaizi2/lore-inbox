Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266091AbUBQGO7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 01:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266037AbUBQGO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 01:14:58 -0500
Received: from mx1.redhat.com ([66.187.233.31]:487 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266094AbUBQGOH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 01:14:07 -0500
Date: Tue, 17 Feb 2004 01:13:59 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Valdis.Kletnieks@vt.edu
cc: Chris Wright <chrisw@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH} 2.6 and grsecurity 
In-Reply-To: <200402170237.i1H2bb3r008280@turing-police.cc.vt.edu>
Message-ID: <Xine.LNX.4.44.0402170110400.19316-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Feb 2004 Valdis.Kletnieks@vt.edu wrote:

> On Mon, 16 Feb 2004 18:15:46 PST, Chris Wright said:
> > * Valdis.Kletnieks@vt.edu (Valdis.Kletnieks@vt.edu) wrote:
> > > Here's the patch, versioned against 2.6.3-rc3-mm1. Comments?
> > 
> > Aside of the dubious security value...the typical no #ifdefs apply here.
> 
> Agreed - the only one that seems at all a *big* win is randomizing PID's
> (and even there it probably should default a higher value for pid_max to
> increase the search space).  But as long as I was looking at it anyhow.. :)

How is this a big win?  Looks like cargo cult security to me.


> > > + * 3. All advertising materials mentioning features or use of this softwar
> e
> > > + *    must display the following acknowledgement:
> > > + *    This product includes software developed by Niels Provos.
> > 
> > Advertsing clause...this is not GPL compatible.
> 

> Or they OK because they're only doing a separately distributed patch?

No.


- james
-- 
James Morris
<jmorris@redhat.com>


