Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269664AbTGXSSV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 14:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269670AbTGXSSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 14:18:21 -0400
Received: from tomts25.bellnexxia.net ([209.226.175.188]:21660 "EHLO
	tomts25-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S269664AbTGXSST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 14:18:19 -0400
Date: Thu, 24 Jul 2003 14:31:05 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: John Bradford <john@grabjohn.com>
cc: diegocg@teleline.es,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ml@basmevissen.nl
Subject: Re: time for some drivers to be removed?
In-Reply-To: <200307241829.h6OITjR3000582@81-2-122-30.bradfords.org.uk>
Message-ID: <Pine.LNX.4.53.0307241422360.21139@localhost.localdomain>
References: <200307241829.h6OITjR3000582@81-2-122-30.bradfords.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jul 2003, John Bradford wrote:

> i wrote:

> > and in the end, while i know some folks don't think it's a big
> > deal, i think doing a "make allyesconfig" really should work.
> 
> It's _counter productive_ just to bodge it so that make allyesconfig
> works.  I _want_ it to _fail_ if the drivers are _broken_.
> 
> A CONFIG_KNOWN_BROKEN option is a good thing, in the case where,
> E.G. a SCSI driver is broken, and will randomly corrupt data, but
> otherwise compiles and appears to work.  Apart from that, it's a
> complete waste of time to fiddle around with silly options that do
> nothing but bloat the codebase and waste developers' time.

whoa, calm down.  i didn't mean to start that kind of flame war. for the
record, i feel that, if something is *known* to be broken, it should not
be in the source tree.  naturally, in the testing process, there will
be stuff that has bugs, which is why we test.  but i'm just not buying
the argument of leaving modules like riscom8 in the tree for release
after release when it hasn't compiled properly for as long as i can
remember.

but the impression i've gotten so far is that some folks are adamant that
some broken/non-updated/legacy/obsolete/whatever code will remain in the
source tree because it might be fixed *some day*.  if that's the case,
then i think such code should be marked or tagged *somehow* as being
broken.

it's a matter of public perception -- it looks bad to ship code that
is *known* not to compile.

and on that note, i'll let this one go.  my $0.02.  $0.03 canadian.

rday

p.s.  and, yes, i think "make allyesconfig" should just plain work
for official release kernels.  so there. :-P
