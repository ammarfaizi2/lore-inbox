Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751294AbVIDIfw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbVIDIfw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 04:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbVIDIfw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 04:35:52 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:53982 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S1751294AbVIDIfv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 04:35:51 -0400
Date: Sun, 4 Sep 2005 08:30:00 +0200 (CEST)
From: =?ISO-8859-15?Q?Peter_M=FCnster?= <pmlists@free.fr>
X-X-Sender: peter@gaston.free.fr
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel freezes with 2.6.12.5 and 2.6.13
In-Reply-To: <20050829215238.GF7762@shell0.pdx.osdl.net>
Message-ID: <Pine.LNX.4.58.0509040820500.22435@gaston.free.fr>
References: <Pine.LNX.4.58.0508292050180.28621@gaston.free.fr>
 <20050829191754.GW7991@shell0.pdx.osdl.net> <Pine.LNX.4.58.0508292253590.32579@gaston.free.fr>
 <20050829215238.GF7762@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Aug 2005, Chris Wright wrote:

> * Peter Münster (pmlists@free.fr) wrote:
> > On Mon, 29 Aug 2005, Chris Wright wrote:
> > 
> > > * Peter Münster (pmlists@free.fr) wrote:
> > > > with 2.6.12.4 no problem. But with a newer version, I get a black screen
> > > > and no more network access, when trying to print (lpr some-file.ps).
> > > > Everything else seems to work ok.
> > > > Printer is a network-printer managed by cups.
> > > > I suppose, it's a smp-problem, so here is my /proc/cpuinfo:
> > > 
> > > Is this 100% reproducible?  Do you get any kernel oops messages on
> > > the console?  There are very few patches between 2.6.12.4 and 2.6.12.5,
> > > so if the problem is reproducible can you narrow to the specific patch?
> > 
> > Yes, it's 100% reproducible. But I do not get any message. Display is
> > shutting down, and no more access with ssh. Ctrl-Alt-Del does not work
> > neither. Nothing in /var/log/messages.
> 
> Are you running X?  Can you reproduce running lpr from console command line?

Friday I got some surprises: I could reproduce now the system crash (always
with lpr and without X) with all other kernels too: 2.6.12.4, 2.6.12 and
even with the kernel, that was really stable for a long time on my system:
2.6.11.3. So now, I believe, that there is a hardware problem.
I'm sorry, having stolen your time...
Greetings, Peter

-- 
http://pmrb.free.fr/contact/
