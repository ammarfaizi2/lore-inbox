Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264785AbTE1QAr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 12:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264787AbTE1QAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 12:00:47 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:9732 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264785AbTE1QAp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 12:00:45 -0400
Date: Wed, 28 May 2003 12:08:03 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Ricky Beam <jfbeam@bluetronic.net>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.70
In-Reply-To: <Pine.GSO.4.33.0305271402420.4448-100000@sweetums.bluetronic.net>
Message-ID: <Pine.LNX.3.96.1030528120009.19675B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 May 2003, Ricky Beam wrote:

> On Tue, 27 May 2003, Linus Torvalds wrote:
> >On Tue, 27 May 2003, Ricky Beam wrote:
> >>
> >> Count up the number of drivers that haven't been updated to the current
> >> PCI, hotplug, and modules interfaces.
> >
> >Tough. If people don't use them, they don't get supported. It's that easy.
> ...
> 
> Allow me to clarify... I don't mind drivers not working.  I *do* mind
> drivers emitting hundreds of warnings and errors because dozens of things
> were changed and no one cared to update everything they broke.  In some
> cases, fixing things may be simple (eg. someone removed or renamed a field
> in a struct somewhere) and in others years of work my be required (eg.
> the new module interface.)
> 
> In my opinion (as it was in the long long ago), everything in a "stable"
> release should at least compile cleanly -- "working" comes later after
> users have been conned into using it.

See the stats posted to lkml from time to time on errors and warnings. The
2.4 stable kernels don't compile cleanly, with some combinations of config
options they may not compile at all. The ones which compile and work, even
with all manner of warnings, are a good place to start doing some
housekeeping and sending it back to the maintainer.

Maintainers vary on their desire to push cosmetic fixes into working
code, even when they are correct.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

