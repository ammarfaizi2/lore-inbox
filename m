Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263350AbTEIR02 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 13:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263353AbTEIR02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 13:26:28 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:40965 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S263350AbTEIR00
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 13:26:26 -0400
Date: Fri, 9 May 2003 19:42:10 +0200
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.69-mm2 Kernel panic, possibly network related
Message-ID: <20030509174210.GA7476@hh.idb.hist.no>
References: <1052304024.9817.3.camel@rth.ninka.net> <Pine.LNX.3.96.1030509085607.26434U-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1030509085607.26434U-100000@gatekeeper.tmr.com>
User-Agent: Mutt/1.5.3i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 09, 2003 at 08:57:48AM -0400, Bill Davidsen wrote:
> On 7 May 2003, David S. Miller wrote:
> 
> > On Wed, 2003-05-07 at 03:10, Helge Hafting wrote:
> > > 2.5.69-mm1 is fine, 2.5.69-mm2 panics after a while even under very
> > > light load.
> > 
> > Do you have AF_UNIX built modular?
> > 
> 
> This may be the same thing reported in
> <20030505144808.GA18518@butterfly.hjsoft.com> earlier, it seems to happen
> in 2.5.69 base. Interesting that he has it working in mm1, perhaps the
> module just didn't get loaded.
> 
> Of course it could be another problem.

It is definitely _not_ the modular AF_UNIX thing,
for the third time - I don't use modules at all.
My kernel doesn't even support module loading.

And it is a netfilter problem.  mm2 and mm3 are nice
and stable when I don't select netfilter for compilation.

Helge Hafting
