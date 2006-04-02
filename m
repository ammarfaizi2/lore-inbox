Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932406AbWDBSCV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406AbWDBSCV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 14:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbWDBSCV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 14:02:21 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:3903 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932406AbWDBSCU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 14:02:20 -0400
Date: Sun, 2 Apr 2006 20:02:16 +0200
From: Jens Axboe <axboe@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] splice exports
Message-ID: <20060402180216.GD14022@suse.de>
References: <20060331040613.GA23511@havoc.gtf.org> <1143802879.3053.3.camel@laptopd505.fenrus.org> <20060331110233.GM14022@suse.de> <442D3608.8090906@garzik.org> <20060331183617.GD14022@suse.de> <442DB7F0.8090000@garzik.org> <1143855184.3076.0.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143855184.3076.0.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 01 2006, Arjan van de Ven wrote:
> On Fri, 2006-03-31 at 18:14 -0500, Jeff Garzik wrote:
> > Jens Axboe wrote:
> > > On Fri, Mar 31 2006, Jeff Garzik wrote:
> > >> Jens Axboe wrote:
> > >>> On Fri, Mar 31 2006, Arjan van de Ven wrote:
> > >>>> On Thu, 2006-03-30 at 23:06 -0500, Jeff Garzik wrote:
> > >>>>> Woe be unto he who builds their filesystems as modules.
> > >>>> since splice support is highly linux specific and new.. shouldn't these
> > >>>> be _GPL exports?
> > >>> Yes they should, I'll add that to the current splice tree.
> > >> Why?  We don't usually restrict filesystems in such ways...  I would 
> > >> rather a binary-only module reference generic_file_splice_read() than 
> > >> create its own.
> > > 
> > > You could use that very same argument for any piece of the kernel, then,
> > > so I don't think that adds much value to _not_ exporting it GPL.
> > 
> > Not really, because I'm considering the Real World(tm) users, not 
> > abstract theory :)  The other filesystem junk is exported non-GPL, and 
> > existing binary-only filesystems use that stuff.
> > 
> > IOW its a bit rude to say "oh you can have your BO filesystem, just not 
> > splice support."
> 
> 
> it's a bit like saying "you can use all the standard unix interfaces,
> but these are very linux specific"; eg the same arguments for making lsm
> and other pieces _GPL; they're so linux specific that users that use
> these do so with linux in mind etc

Linus seems to agree with the _GPL not being appropriate as well, so I
guess I'll bow to the majority. This time :-)

-- 
Jens Axboe

