Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261582AbVDEIef@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbVDEIef (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 04:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbVDEIed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 04:34:33 -0400
Received: from mx1.suse.de ([195.135.220.2]:13512 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261673AbVDEIck (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 04:32:40 -0400
Subject: Re: [PATCH 00/04] Load keyspan firmware with hotplug
From: Kay Sievers <kay.sievers@vrfy.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Jan Harkes <jaharkes@cs.cmu.edu>, Greg KH <greg@kroah.com>,
       Sven Luther <sven.luther@wanadoo.fr>,
       Michael Poole <mdpoole@troilus.org>, debian-legal@lists.debian.org,
       debian-kernel@lists.debian.org, linux-kernel@vger.kernel.org
In-Reply-To: <200504042351.22099.dtor_core@ameritech.net>
References: <20050404100929.GA23921@pegasos>
	 <20050404191745.GB12141@kroah.com>
	 <20050405042329.GA10171@delft.aura.cs.cmu.edu>
	 <200504042351.22099.dtor_core@ameritech.net>
Content-Type: text/plain
Date: Tue, 05 Apr 2005 10:32:38 +0200
Message-Id: <1112689958.6702.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 (2.2.1.1-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-04-04 at 23:51 -0500, Dmitry Torokhov wrote:
> On Monday 04 April 2005 23:23, Jan Harkes wrote:
> > On Mon, Apr 04, 2005 at 12:17:46PM -0700, Greg KH wrote:
> > > On Mon, Apr 04, 2005 at 08:27:53PM +0200, Sven Luther wrote:
> > > > Mmm, probably that 2001 discussion about the keyspan firmware, right ?
> > > > 
> > > >   http://lists.debian.org/debian-legal/2001/04/msg00145.html
> > > > 
> > > > Can you summarize the conclusion of the thread, or what you did get from it,
> > > > please ? 
> > > 
> > > That people didn't like the inclusion of firmware, I posted how you can
> > > fix it by moving it outside of the kernel, and asked for patches.
> > > 
> > > None have come.
> > 
> > Didn't know you were waiting for it. How about something like the
> > following series of patches?
> > 
> > [01/04] - add simple Intel IHEX format parser to the firmware loader.
> 
> Firmware loader is format-agnostic, I think having IHEX parser in a separate
> file would be better...

Why should this be in-kernel at all? Convert the firmware into a binary
blob or do it in the userspace request.

Kay

