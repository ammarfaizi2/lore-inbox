Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261420AbSJMDpJ>; Sat, 12 Oct 2002 23:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261421AbSJMDpJ>; Sat, 12 Oct 2002 23:45:09 -0400
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:5248 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S261420AbSJMDpI>;
	Sat, 12 Oct 2002 23:45:08 -0400
Date: Sat, 12 Oct 2002 22:50:46 -0500 (CDT)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: "Murray J. Root" <murrayr@brain.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.42 ide-scsi loads!
In-Reply-To: <20021012232843.GA1663@Master.Wizards>
Message-ID: <Pine.LNX.4.44.0210122249190.1277-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Oct 2002, Murray J. Root wrote:

> On Sat, Oct 12, 2002 at 05:46:07PM -0500, Thomas Molina wrote:
> > On Sat, 12 Oct 2002, Murray J. Root wrote:
> > 
> > > It's fixed.
> > > ide-scsi loaded 4 out of 4 tries.
> > 
> > Modular?  If yes, try rmmod ide-scsi.  I am still getting the exact same 
> > oops and hang I got in:
> > 
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=103351991417181&w=2
> > 
> > To summarize:  If I load ide-scsi on boot and don't remove any components 
> > while up I don't have a problem.  If I rmmod and ide-scsi related module I 
> > get an oops with apparent register poisoning (signature 5a5a5a5a in the 
> > register).  After one of these oops I get a hang on shutdown.  The oops 
> > and hang I get in 2.5.42 is exactly the same as that in the cited message.
> 
> Ugh. Here I was all happy that my ide-scsi works and you had to go mess it up.
> 
> rmmod fails spectacularly.

Sorry about that :)  

It happens with any ide-scsi module (sg, sr_mod, etc).  However, it does 
work well if you don't try to remove them.

