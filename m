Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264625AbSJOJgp>; Tue, 15 Oct 2002 05:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264631AbSJOJgp>; Tue, 15 Oct 2002 05:36:45 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:8070 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S264625AbSJOJgo>;
	Tue, 15 Oct 2002 05:36:44 -0400
Date: Tue, 15 Oct 2002 11:42:00 +0200
From: Jens Axboe <axboe@suse.de>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>,
       Kernel mailing list <linux-kernel@vger.kernel.org>,
       Harald Dankworth <harald@pronto.tv>,
       Atle =?iso-8859-1?Q?Sj=F8n=F8st?= <atle@pronto.tv>
Subject: Re: cdrom_sysctl_register uses LOTS of CPU, and no cdrom is attached (2.4.20-pre10)
Message-ID: <20021015094200.GA14722@suse.de>
References: <Pine.LNX.4.44.0210150102120.1795-100000@montezuma.mastecende.com> <200210150949.16991.roy@karlsbakk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210150949.16991.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15 2002, Roy Sigurd Karlsbakk wrote:
> On Tuesday 15 October 2002 07:07, Zwane Mwaikambo wrote:
> > On Mon, 14 Oct 2002, Roy Sigurd Karlsbakk wrote:
> > > attached is the .config and these three readprofile output files
> > > (pro[123]). see time to see the interval they have been created in
> >
> > These look like bungled up profiles of the magnitude that even i couldn't
> > conjure up ;)
> 
> excuse me?
> made a new one now.
> 
> why is cdrom_sysctl_register using all that cpu??? I mean - it's got nothing 
> there to do!

come on, the profile data is obvious bogus. take a look at
cdrom_sysctl_register(), for chrissake.

-- 
Jens Axboe

