Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264023AbTE3Wlp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 18:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264002AbTE3Wlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 18:41:45 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33461 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264023AbTE3Wlo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 18:41:44 -0400
Date: Fri, 30 May 2003 23:55:04 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Davide Libenzi <davidel@xmailserver.org>,
       =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5 Documentation/CodingStyle ANSI C function declarations.
Message-ID: <20030530225504.GK9502@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.55.0305301535100.4421@bigblue.dev.mcafeelabs.com> <Pine.LNX.4.44.0305301546580.3089-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305301546580.3089-100000@home.transmeta.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 30, 2003 at 03:49:12PM -0700, Linus Torvalds wrote:
> 
> On Fri, 30 May 2003, Davide Libenzi wrote:
> > 
> > Talking about the code, there are still a bunch of files that uses spaces
> > with tabsize=4. Shouldn't those be reformatted with real TABs ? An emacs
> > lisp (indent+tabify) might do it pretty fast ...
> 
> I don't generally like changing syntactic stuff without a reason.
> 
> A good reason is when the original maintainer is not that active any more,
> and a new maintainer (or even just random fixer) feels that they need to
> run indent on the sources in order to make them more readable before 
> doign a fix.
> 
> It happens, but not very often. Alan and Al both do it to the files they 
> clean up. But I don't like having it done "just because" - there should be 
> a real underlying reason.

FWIW, I'd ran Lindent maybe 10 times or so - only in truly appalling cases
when it hurts just looking at the code (drivers/block/paride, mostly - just
take a look at it in 2.4).  Usually it's more of "I change that function;
might as well reindent it" and it's done manually.
