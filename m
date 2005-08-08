Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753219AbVHHBiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753219AbVHHBiH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 21:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753221AbVHHBiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 21:38:07 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:49323 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S1753219AbVHHBiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 21:38:06 -0400
Subject: Re: [linux-pm] [PATCH] Workqueue freezer support.
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Con Kolivas <kernel@kolivas.org>
Cc: Patrick Mochel <mochel@digitalimplant.org>,
       Christoph Lameter <christoph@lameter.com>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200508081127.48432.kernel@kolivas.org>
References: <1121923059.2936.224.camel@localhost>
	 <Pine.LNX.4.50.0508052148280.19501-100000@monsoon.he.net>
	 <1123462015.3969.98.camel@localhost>
	 <200508081127.48432.kernel@kolivas.org>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1123465087.3969.152.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Mon, 08 Aug 2005 11:38:07 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, 2005-08-08 at 11:27, Con Kolivas wrote:
> On Mon, 8 Aug 2005 10:46 am, Nigel Cunningham wrote:
> > Hi.
> >
> > Sorry for the slow response. Busy still.
> >
> > On Sat, 2005-08-06 at 15:06, Patrick Mochel wrote:
> > > On Fri, 5 Aug 2005, Nigel Cunningham wrote:
> > > > Hi.
> > > >
> > > > I finally found some time to finish this off. I don't really like the
> > > > end result - the macros looked clearer to me - but here goes. If it
> > > > looks okay, I'll seek sign offs from each of the affected driver
> > > > maintainers and from Ingo. Anyone else?
> > >
> > > What are your feelings about this: http://lwn.net/Articles/145417/ ?
> >
> > I'm sure it could work, but I do worry a little about the possibilities
> > for exploits. It seems to me that if someone can get root, they an
> > insmod a module that could schedule any kind of work via any process.
> > Tracing that sort of security hole could be intractable. Christoph, is
> > that something you've considered/have thoughts on? Perhaps I'm just
> > being paranoid :>
> 
> If someone gets root access it means you're already exploited.

Yeah, true. Ok. Lame thought :>

Nigel

> Cheers,
> Con
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.

