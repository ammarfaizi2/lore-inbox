Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262963AbTJEDqG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 23:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262965AbTJEDqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 23:46:06 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:42949 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S262963AbTJEDqD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 23:46:03 -0400
Date: Sat, 4 Oct 2003 20:45:33 -0700
From: Larry McVoy <lm@bitmover.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Larry McVoy <lm@bitmover.com>, Rob Landley <rob@landley.net>,
       andersen@codepoet.org, "Henning P. Schmiedehausen" <hps@intermeta.de>,
       Andre Hedrick <andre@linux-ide.org>, linux-kernel@vger.kernel.org
Subject: Re: freed_symbols [Re: People, not GPL [was: Re: Driver Model]]
Message-ID: <20031005034533.GA29679@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	viro@parcelfarce.linux.theplanet.co.uk,
	Larry McVoy <lm@bitmover.com>, Rob Landley <rob@landley.net>,
	andersen@codepoet.org,
	"Henning P. Schmiedehausen" <hps@intermeta.de>,
	Andre Hedrick <andre@linux-ide.org>, linux-kernel@vger.kernel.org
References: <20030914064144.GA20689@codepoet.org> <bk30f1$ftu$2@tangens.hometree.net> <20030915055721.GA6556@codepoet.org> <200310041952.09186.rob@landley.net> <20031005010521.GA21138@work.bitmover.com> <20031005023428.GI7665@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031005023428.GI7665@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.3,
	required 7, AWL)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 05, 2003 at 03:34:28AM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Sat, Oct 04, 2003 at 06:05:21PM -0700, Larry McVoy wrote:
> > 
> > Yeah, but Linus stating his position about a license doesn't mean diddly.
> > The kernel is licensed under a license, that license is a contract that
> > people enter into.  To the extent that it is enforceable, that license
> > determines what happens, Linus can't retroactively decide to interpret
> > the license a different way.  The license can't enforce things which
> > the law doesn't allow.  In particular, the law understands a concept of
> > a boundary.  And Linus' comments notwithstanding, modules are a pretty
> > clear boundary.  Even the GPL acks this, it knows that anything which
> > is clearly separable is not covered.
> 
> Oh, for fuck sake!  Larry, grep the damn tree for EXPORT_SYMBOL.  And
> count them.  _IF_ it would be a relatively sane set of primitives - sure,
> no arguments.  It's not.  Nowhere near that.

You're missing what the law sees as a boundary.  It's really simple,
as far as I can tell, and it doesn't matter how many symbols there are
or are not.  If you can pull out one wad of code and drop in another
and everything works as before then that is a boundary.

A great example of this is a device driver.  Again, I'm not a lawyer
although I've spent a fair amount of time discussing this topic with
lawyers, but it sure seems like that an objective judge would say that
the GPL cannot cross the device driver boundary.

People get all worked up over this but when they do then they should
also claim that system calls are not a boundary either.

By the way, I have no personal or business desire to argue this one way
or the other, I'm not trying to make money off of something like a driver
linked with the kernel or anything remotely similar.  All I'm doing is
telling you what I understand to be the law.  You can do with it what
you will but don't shoot the messenger (or at least don't expect me to
change my tune when you do).
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
