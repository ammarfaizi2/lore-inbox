Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263668AbTEJHRr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 03:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263669AbTEJHRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 03:17:47 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:18127 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263668AbTEJHRq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 03:17:46 -0400
Date: Sat, 10 May 2003 09:30:24 +0200
From: Jens Axboe <axboe@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>,
       Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.69-mm2 Kernel panic, possibly network related
Message-ID: <20030510073024.GH812@suse.de>
References: <20030507215430.GA1109@hh.idb.hist.no> <20030508013854.GW8931@holomorphy.com> <20030508065440.GA1890@hh.idb.hist.no> <20030508080135.GK8978@holomorphy.com> <20030508100717.GN8978@holomorphy.com> <3EBA4529.7050507@aitel.hist.no> <20030508120450.GT823@suse.de> <20030508133908.GA824@hh.idb.hist.no> <20030508133744.GD823@suse.de> <20030510070324.GF8978@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030510070324.GF8978@holomorphy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 10 2003, William Lee Irwin III wrote:
> On Thu, May 08 2003, Helge Hafting wrote:
> >> Much fuzz and two rejects.  Seems there is ongoing netfilter
> >> work in mm3.
> 
> On Thu, May 08, 2003 at 03:37:44PM +0200, Jens Axboe wrote:
> > akpm applied the patch rusty sent, you'd surely want to back that out
> > first.
> > dunno what else is in -mm, the patch reversed without incident on 2.5-bk
> > as of right now.
> 
> It looks like rusty's patch only caught one of two bugs of the same
> flavor and davem cleaned up the second. It looks like we're in good
> shape on both fronts from where I'm standing but we should probably
> wait for all of the original bugreporters to get back to use to
> declare success on all fronts.

As I wrote yesterday, bk-current has the fix from Davem that works for
me.

-- 
Jens Axboe

