Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946002AbWBCV6r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946002AbWBCV6r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 16:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946003AbWBCV6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 16:58:47 -0500
Received: from solarneutrino.net ([66.199.224.43]:28935 "EHLO
	tau.solarneutrino.net") by vger.kernel.org with ESMTP
	id S1946002AbWBCV6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 16:58:46 -0500
Date: Fri, 3 Feb 2006 16:10:15 -0500
To: Hugh Dickins <hugh@veritas.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kai Makisara <Kai.Makisara@kolumbus.fi>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       Roland Dreier <rdreier@cisco.com>, Brian King <brking@us.ibm.com>,
       Willem Riede <osst@riede.org>, Doug Gilbert <dougg@torque.net>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: Fw: crash on x86_64 - mm related?
Message-ID: <20060203211015.GA555@tau.solarneutrino.net>
References: <20060105201249.GB1795@tau.solarneutrino.net> <Pine.LNX.4.64.0601051312380.3169@g5.osdl.org> <20060109033149.GC283@tau.solarneutrino.net> <Pine.LNX.4.64.0601082000450.3169@g5.osdl.org> <Pine.LNX.4.61.0601090933160.7632@goblin.wat.veritas.com> <20060109185350.GG283@tau.solarneutrino.net> <Pine.LNX.4.61.0601091922550.15426@goblin.wat.veritas.com> <20060118001252.GB821@tau.solarneutrino.net> <Pine.LNX.4.61.0601181556050.9110@goblin.wat.veritas.com> <Pine.LNX.4.61.0602031842290.14065@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0602031842290.14065@goblin.wat.veritas.com>
User-Agent: Mutt/1.5.9i
From: Ryan Richter <ryan@tau.solarneutrino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2006 at 07:46:24PM +0000, Hugh Dickins wrote:
> On Wed, 18 Jan 2006, Hugh Dickins wrote:
> > On Tue, 17 Jan 2006, Ryan Richter wrote:
> > 
> > > This machine experienced another random reboot today, nothing in the
> > > logs or on the console etc.  This is the 3rd time now since I upgraded
> > > from 2.6.11.3.  Is there any way to debug something like this?
> > 
> > Nasty.  I hope someone else can suggest something constructive.
> 
> Are they still happening?
> 
> > > I'm fairly certain it's not hardware-related.
> > > Might this have something to do with the st problem?
> > 
> > Well, it might: I've not been able to explain that at all, so cannot
> > rule out a relation to your reboots.
> 
> If no "Bad page state" has occurred earlier, we can now be sure that
> these reboots are (unfortunately) unrelated to the st problem.

It must not be related then, since it never stayed up more than a few
seconds after that happened.

I've tried disabling the hangcheck timer and the software watchdog as a
shot in the dark, but it's only been a week since then and these seem to
happen about every 3 weeks or so.  Quite a pain to debug.

-ryan
