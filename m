Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932571AbWCWXlR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932571AbWCWXlR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 18:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932578AbWCWXlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 18:41:17 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:17562 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932571AbWCWXlQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 18:41:16 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Mark Lord <lkml@rtr.ca>
Subject: Re: [PATCH] swsusp: separate swap-writing/reading code
Date: Fri, 24 Mar 2006 00:39:41 +0100
User-Agent: KMail/1.9.1
Cc: Nigel Cunningham <ncunningham@cyclades.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@osdl.org>
References: <200603231702.k2NH2OSC006774@hera.kernel.org> <200603232253.01025.rjw@sisk.pl> <442325DA.80300@rtr.ca>
In-Reply-To: <442325DA.80300@rtr.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603240039.42165.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday 23 March 2006 23:48, Mark Lord wrote:
> Rafael J. Wysocki wrote:
> >
> > I agree it probably may be improved.  Still it seems to be good enough.  Further,
> > it's more efficient than the previous solution, so I consider it as an improvement.
> > Also this code has been tested for quite some time in -mm and appears to
> > behave properly, at least we haven't got any bug reports related to it so far.
> 
> I find the in-kernel swsusp to be quite slow, and it seems to use
> an awful lot of memory for book-keeping.  So count that as encouragement
> to improve the performance when you can.

This particular patch actually decreases the amount of memory used by swsusp.

Moreover I have _nothing_ against improvements, but it requires some time to
improve things.

> > Currently I'm not working on any better solution.  If you can provide any
> > patches to implement one, please submit them, but I think they'll have to be
> > tested for as long as this code, in -mm.
> 
> It would be *really nice* if you guys could stop being so underhandedly
> nasty in every single reply to anything from Nigel.

Well, you know, it's generally easy to say that something's done in a wrong
way, but this alone doesn't help _anyone_.

Suggestions are nice, but _someone_ has to implement them and I think
Nigel is more than capable of doing it in this particular case.  Also the code
in question is quite sensitive and such that it should be tested for a longer
time IMO.

That's what I was trying to say and it was not my intention to be nasty at all.

Greetings,
Rafael
