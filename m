Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263551AbTDTKiO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 06:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263552AbTDTKiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 06:38:13 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:25869 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S263551AbTDTKiM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 06:38:12 -0400
Date: Sun, 20 Apr 2003 12:51:54 +0200
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: Are linux-fs's drive-fault-tolerant by concept?
Message-ID: <20030420105154.GA16451@hh.idb.hist.no>
References: <20030419180421.0f59e75b.skraw@ithnet.com> <87lly6flrz.fsf@deneb.enyo.de> <20030419200712.3c48a791.skraw@ithnet.com> <20030419184120.GH669@gallifrey> <20030419205621.GA15577@hh.idb.hist.no> <200304192115.h3JLFVuL018983@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304192115.h3JLFVuL018983@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.3i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 19, 2003 at 05:15:31PM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Sat, 19 Apr 2003 22:56:21 +0200, Helge Hafting said:
> 
> > There are commercially available programs that guarantees to
> > wipe your drive clean - including hidden areas and remapped
> > sectors.  You should then be able to send drives
> > back for warranty replacement.
> 
> These don't address the problem - if the drive won't go "ready" because
> of a blown server platter, your data won't get overwritten but it's still
> readable (a number of companies make good money at this).
> 
I see.  Your data is so special that you expect people to pay for
reconstruction hoping to find something that pays for all
that trouble and more.

> In general, if the disk is dead enough that you're looking at replacement,
> you'll probably not be totally pleased with the results of those programs..
> 
I have replaced a couple of drives in my life - because a few sectors
didn't read back right.  I expect a overwrite program to be just
fine under such circumstances.  

> > There are also bulk erasers that reset every bit magnetically,
> > but those will probably void the warranty too.  (You'll
> > need a low-level reformat to recreate sector addresses on the
> > suddenly blank surface.)
> 
> Note that this only works well for single-platter disks - the field
> you need to get the *inner* surfaces of the platters, especially for
> a 5 or 6 platter disk, is quite astounding....

Why would it be hard to reach the inner surfaces - the disks
are not superconducting so the outer ones do not shield the
inner ones from a strong magnetic field.  You should be fine
as long as the field extend far enough to get the entire
drive.  A high-frequency device might have trouble,
but you don't need that - even a static field will do.

Helge Hafting


