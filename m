Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751466AbWDABdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbWDABdY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 20:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbWDABdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 20:33:24 -0500
Received: from morbo.e-centre.net ([66.154.82.3]:32491 "EHLO
	cubert.e-centre.net") by vger.kernel.org with ESMTP
	id S1751466AbWDABdX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 20:33:23 -0500
X-ASG-Debug-ID: 1143855187-22952-169-0
X-Barracuda-URL: http://10.3.1.19:8000/cgi-bin/mark.cgi
X-ASG-Orig-Subj: Re: [PATCH] splice exports
Subject: Re: [PATCH] splice exports
From: Arjan van de Ven <arjan@infradead.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <442DB7F0.8090000@garzik.org>
References: <20060331040613.GA23511@havoc.gtf.org>
	 <1143802879.3053.3.camel@laptopd505.fenrus.org>
	 <20060331110233.GM14022@suse.de> <442D3608.8090906@garzik.org>
	 <20060331183617.GD14022@suse.de>  <442DB7F0.8090000@garzik.org>
Content-Type: text/plain
Date: Sat, 01 Apr 2006 03:33:03 +0200
Message-Id: <1143855184.3076.0.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=4.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.10331
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-31 at 18:14 -0500, Jeff Garzik wrote:
> Jens Axboe wrote:
> > On Fri, Mar 31 2006, Jeff Garzik wrote:
> >> Jens Axboe wrote:
> >>> On Fri, Mar 31 2006, Arjan van de Ven wrote:
> >>>> On Thu, 2006-03-30 at 23:06 -0500, Jeff Garzik wrote:
> >>>>> Woe be unto he who builds their filesystems as modules.
> >>>> since splice support is highly linux specific and new.. shouldn't these
> >>>> be _GPL exports?
> >>> Yes they should, I'll add that to the current splice tree.
> >> Why?  We don't usually restrict filesystems in such ways...  I would 
> >> rather a binary-only module reference generic_file_splice_read() than 
> >> create its own.
> > 
> > You could use that very same argument for any piece of the kernel, then,
> > so I don't think that adds much value to _not_ exporting it GPL.
> 
> Not really, because I'm considering the Real World(tm) users, not 
> abstract theory :)  The other filesystem junk is exported non-GPL, and 
> existing binary-only filesystems use that stuff.
> 
> IOW its a bit rude to say "oh you can have your BO filesystem, just not 
> splice support."


it's a bit like saying "you can use all the standard unix interfaces,
but these are very linux specific"; eg the same arguments for making lsm
and other pieces _GPL; they're so linux specific that users that use
these do so with linux in mind etc


