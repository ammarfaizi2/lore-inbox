Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263795AbUGFMK3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263795AbUGFMK3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 08:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263790AbUGFMK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 08:10:29 -0400
Received: from colin2.muc.de ([193.149.48.15]:21260 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S263795AbUGFMK1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 08:10:27 -0400
Date: 6 Jul 2004 14:10:23 +0200
Date: Tue, 6 Jul 2004 14:10:23 +0200
From: Andi Kleen <ak@muc.de>
To: "R. J. Wysocki" <rjwysocki@sisk.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: x86-64 documentation
Message-ID: <20040706121023.GA21440@muc.de>
References: <200407042046.20124.rjwysocki@sisk.pl> <200407061206.01734.rjwysocki@sisk.pl> <20040706113148.GA3050@muc.de> <200407061352.48108.rjwysocki@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407061352.48108.rjwysocki@sisk.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2004 at 01:52:48PM +0200, R. J. Wysocki wrote:
> On Tuesday 06 of July 2004 13:31, Andi Kleen wrote:
> > On Tue, Jul 06, 2004 at 12:06:01PM +0200, R. J. Wysocki wrote:
> > > On Sunday 04 of July 2004 21:46, Andi Kleen wrote:
> > > > On Sun, Jul 04, 2004 at 08:46:20PM +0200, R. J. Wysocki wrote:
> > > > > I've just read the Documentation/x86_64/mm.txt.  Is it up to date?
> > > >
> > > > Mostly yes.
> > >
> > > How about kernel stacks?  Are they still 16k or they are 8k now?
> >
> > They were always 8k
> 
> Hm.  Does this mean that one register is reserved for the task_struct pointer 
> etc. (as stated in mm.txt) or is it done in a different way?

GS points to a per CPU data structure and the current task is read from
that.

-Andi
