Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262379AbTENCBh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 22:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262454AbTENCBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 22:01:37 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:3593 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP id S262379AbTENCBf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 22:01:35 -0400
Date: Tue, 13 May 2003 19:12:10 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: What exactly does "supports Linux" mean?
Message-ID: <20030514021210.GD30766@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <200305131114_MC3-1-38B0-3C13@compuserve.com> <yw1x3cjifutq.fsf@zaphod.guide>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1x3cjifutq.fsf@zaphod.guide>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 10:36:01PM +0200, Måns Rullgård wrote:
> Chuck Ebbert <76306.1226@compuserve.com> writes:
> 
> > > My general conclusion would be that something not working with a standard
> > > kernel cannot be called "supporting linux", no matter what distros ever are
> > > supported. You may call me purist...
> > 
> >   If their drivers don't come with full source code then their claims
> > of supporting Linux are just a bad joke AFAIC.
> 
> Even when they do, it's often far from what I would call "Linux
> support".  I've seen vendor drivers that made such assumptions about
> the machine that they would only work on IA-32 machines.  I'm talking
> about things like assuming that sizof(int) == sizeof(void *) == 4, or
> that physical memory addresses are the same seen from the CPU and from
> the PCI bus.

This is really a trademark related labelling issue.  The
trademark allows Linus or his assignee to specify in what
way Linux(tm) may be used in labelling and advertising.
Linux is just like other products with third-party parts and
supplies.  If Linus's assignee (Linux international?) where
to specify explicit guidelines then people would know what
to expect.  Something like:

Linux certified:
	Mainline kernel has driver and it has been certified
	as functioning with this hardware by OSDL or some
	other officially sanctioned lab.

Linux supported:
	Mainline kernel has driver.

Linux compatible:
	Source code driver available as a patch.

Runs on Linux:
	Binary only driver available that can be used with
	mainline kernel.

Supports Linux:
	Portion of the purchase price will be donated to
	Linux International.

You will notice this all relates to mainline kernels (Linus
and Marcello).  If the product requires a vendor kernel they
need to negotiate with the vendor to say so.

These are just suggestions.  Many other products (including
MS windows) have similar labelling restrictions, often with
logos.  Use of the term "Linux" in packaging or advertising
or products inconsistent with the official designations would
be trademark infringement.  Different rules would apply to
products that exist strictly in user-space.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
