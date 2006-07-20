Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030344AbWGTP66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030344AbWGTP66 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 11:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030346AbWGTP66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 11:58:58 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:3760 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1030344AbWGTP65 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 11:58:57 -0400
Date: Thu, 20 Jul 2006 17:59:09 +0200
From: Pavel Machek <pavel@suse.cz>
To: Joachim Deguara <joachim.deguara@amd.com>
Cc: "shin, jacob" <jacob.shin@amd.com>, Andi Kleen <ak@suse.de>,
       "Langsdorf, Mark" <mark.langsdorf@amd.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, cpufreq@lists.linux.org.uk
Subject: Re: [discuss] Re: [PATCH] Allow all Opteron processors to change pstate at same time
Message-ID: <20060720155909.GA31504@atrey.karlin.mff.cuni.cz>
References: <B3870AD84389624BAF87A3C7B831499302935A76@SAUSEXMB2.amd.com> <20060713130604.GC8230@ucw.cz> <1152801132.4519.10.camel@lapdog.site> <20060716015636.GC21162@atrey.karlin.mff.cuni.cz> <1153121830.3917.2.camel@lapdog.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1153121830.3917.2.camel@lapdog.site>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sun, 2006-07-16 at 03:56 +0200, Pavel Machek wrote:
> > > On Thu, 2006-07-13 at 13:06 +0000, Pavel Machek wrote:
> > > > Can you run two such tests *in parallel*? That seemed to break it
> > > > really quickly.
> > > parallel sounds fun, but I don't get it.  Two machine or trying to
> > go
> > > online and offline at the same time?  Firestorming two busy parallel
> > 
> > Trying to online and offline at the same time.
> > 
> > > while loops, one turning the core offline and the other online, did
> > not
> > > bring an oops so I guess this kernel is in the clear in that regard.
> > 
> > Better run two tight loops, each doing online; offline. I got reports
> > it crashed machines before, but maybe it is solved. 
> 
> yeah, that's what I did. Somethings are easier described in bash than in
> english.  Nothing crashed or oopsed so the green light is there for
> online and offline in 2.6.18-rc1 (with my setup).

Okay, I tried hard here, and reproduced some fork failures (and swsusp
panic :-), but not oops.

								Pavel
-- 
Thanks, Sharp!
