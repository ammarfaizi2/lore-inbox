Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264070AbTE0SLc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 14:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264050AbTE0SKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 14:10:47 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:8660
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S264063AbTE0SJ3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 14:09:29 -0400
Date: Tue, 27 May 2003 14:22:41 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Ricky Beam <jfbeam@bluetronic.net>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.70
Message-ID: <20030527182241.GF21744@gtf.org>
References: <Pine.LNX.4.44.0305271024060.6597-100000@penguin.transmeta.com> <Pine.GSO.4.33.0305271402420.4448-100000@sweetums.bluetronic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.33.0305271402420.4448-100000@sweetums.bluetronic.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 27, 2003 at 02:09:43PM -0400, Ricky Beam wrote:
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

No.  Doing this hides bugs.

We use the compiler to make bugs and needing-work areas blindingly
obviously.  Your suggesting we make them less so.

	Jeff



