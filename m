Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272007AbTGYKpj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 06:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272008AbTGYKpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 06:45:35 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:14465 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S272007AbTGYKpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 06:45:34 -0400
Date: Fri, 25 Jul 2003 12:10:25 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200307251110.h6PBAPVO000497@81-2-122-30.bradfords.org.uk>
To: john@grabjohn.com, ml@basmevissen.nl
Subject: Re: time for some drivers to be removed?
Cc: diegocg@teleline.es, linux-kernel@vger.kernel.org, rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > A CONFIG_KNOWN_BROKEN option is a good thing, in the case where,
> > E.G. a SCSI driver is broken, and will randomly corrupt data, but
> > otherwise compiles and appears to work.  
>
> I agree on that.
>
> Maybe I should make my point more clear. What bothers me is that a lot 
> of (early 2.4) kernel versions could easely be configured non-compiling. 
> Not just for exotic configurations, but also when building for an 
> average PC.
>
> That is very confusing (and anoying) for all kernel builders, as you can 
> not always easely tell if the kernel doesn't compile because of 
> misconfiguration or because of code errors.
>
> I hope that this can be avoided for 2.6.0. "Fixing" device drivers by 
> calling them obsolete, is not the right way. Because drivers that are 
> broken and fixed by nobody might not be obsolete.
>
> So for 2.6.0, I propose to only mark obsolete what is really obsolete. 
> Maybe everything that is broken since 2.2 and nobody complained about 
> it. Then, mark broken what is broken for some time and nobody is 
> (currenly) willing/able to fix.

Hmmm, maybe it's just me, but I think of obsolete as meaning something
that's due to be removed whether it works or not, because it's
functionality is no longer required.  I thought we had
CONFIG_EXPERIMENTAL for not sufficiently tested code.

It always used to be that with no CONFIG_EXPERIMENTAL tagged code
compiled in, it was very rare to get a compile failiure.  You could
rely on any kernel building, as long as you didn't touch
CONFIG_EXPERIMENTAL.

Unfortunately, what seems to have happened is that things that really
should be tagged with CONFIG_EXPERIMENTAL, are so desired by a lot of
users that they are being moved out of the experimental phase too
soon.

John.
