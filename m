Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbTEHNZK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 09:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261580AbTEHNZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 09:25:10 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:22176 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261566AbTEHNZH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 09:25:07 -0400
Date: Thu, 8 May 2003 15:37:44 +0200
From: Jens Axboe <axboe@suse.de>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.69-mm2 Kernel panic, possibly network related
Message-ID: <20030508133744.GD823@suse.de>
References: <20030507144100.GD8978@holomorphy.com> <20030507.064010.42794250.davem@redhat.com> <20030507215430.GA1109@hh.idb.hist.no> <20030508013854.GW8931@holomorphy.com> <20030508065440.GA1890@hh.idb.hist.no> <20030508080135.GK8978@holomorphy.com> <20030508100717.GN8978@holomorphy.com> <3EBA4529.7050507@aitel.hist.no> <20030508120450.GT823@suse.de> <20030508133908.GA824@hh.idb.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030508133908.GA824@hh.idb.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 08 2003, Helge Hafting wrote:
> On Thu, May 08, 2003 at 02:04:50PM +0200, Jens Axboe wrote:
> > On Thu, May 08 2003, Helge Hafting wrote:
> > > William Lee Irwin III wrote:
> > > 
> > > >2.5.69-mm3 should suffice to test things now. If you can try that when
> > > >you get back I'd be much obliged.
> > > 
> > > 2.5.69-mm3 died in exactly the same way - the oops was identical.
> > > I'm back to running mm2 without netfilter, to see how
> > > stable it is.
> > 
> > See my mail to rusty, I'm seeing the same thing. Back out the changeset
> > that wli pasted here too, and it will work.
> > 
> Much fuzz and two rejects.  Seems there is ongoing netfilter
> work in mm3.

akpm applied the patch rusty sent, you'd surely want to back that out
first.

dunno what else is in -mm, the patch reversed without incident on 2.5-bk
as of right now.

-- 
Jens Axboe

