Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbTJ3FgN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 00:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262130AbTJ3FgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 00:36:13 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:13731
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S262129AbTJ3FgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 00:36:11 -0500
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Steven Cole <elenstev@mesatop.com>, linux-kernel@vger.kernel.org
Subject: Re: Suspend to disk panicked in -test9.
Date: Wed, 29 Oct 2003 23:33:06 -0600
User-Agent: KMail/1.5
References: <200310291857.40722.rob@landley.net> <200310291935.28554.elenstev@mesatop.com>
In-Reply-To: <200310291935.28554.elenstev@mesatop.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310292333.06470.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 29 October 2003 20:35, Steven Cole wrote:
> On Wednesday 29 October 2003 05:57 pm, Rob Landley wrote:
> > Unfortunately, while I was writing down the panic on a piece of paper,
> > the screen blanking code kicked in while I was still copying down the
> > register values.  I remember that the call trace mentioned some variant
> > of a write_stuff_to_disk call, but that's not that useful...
> >
> > When is the last time that the screen blanking code actually accomplished
> > something useful?  These days it seems to exist for the purpose of
> > destroying panic call traces and annoying people.  (I seem to remember
> > that pressing a key used to make it come back, but now we're forced to
> > use the input core that no longer seems to be the case...)
> >
> > I also seem to remember a patch floating by on the list that would make
> > console screen blanking go away.  I really think console screen blanking
> > NOT being enabled should be the default these days.  Or at the very
> > least, when there's a panic it should get shut off.  I'll add looking
> > into that to my to-do list, but will probably get to it somewhere around
> > 2009...
> >
> > Rob
>
> In the meantime, keeping a digital camera close by when testing is a
> low tech/high tech solution to this.

Very few McDonalds have a digital camera behind the register to loan out.  I 
was lucky they printed out some blank cash register paper for me to write the 
panic down on.  (Ordinarily, I take notes on my laptop...)

If this was easily reproducible, I'd recreate it at home under a serial 
console.  (Well, this being a "modern" laptop with no serial port, maybe I 
could I could rig up a parallel port console or something.  But the 
principle's the same.  No, don't ask me why this thing has no serial port but 
does have a parallel port.  Ask IBM.)

Does netconsole handle panics?  (Would it work through a wireless card on an 
internal cardbus?  I also have a pcmcia 10baseT card around here somewhere I 
could plug a some cat5 into, if I can get any untangled from the big ball of 
miscelanous obsolete computer stuf in the "old parts" box.  It's been a 
couple months since I needed to reclaim anything that box, but I think I know 
where I left it.  I vaguely remember a friend asking me what an 
unrecognizable component was...  For the record, it was a 5 1/4 to 3.5 floppy 
cable adapter...)

> Steven

Rob
