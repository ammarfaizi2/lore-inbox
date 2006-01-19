Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030275AbWASXjB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030275AbWASXjB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 18:39:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030326AbWASXjB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 18:39:01 -0500
Received: from smtp.osdl.org ([65.172.181.4]:56737 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030275AbWASXjA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 18:39:00 -0500
Date: Thu, 19 Jan 2006 15:40:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: davej@redhat.com, davej@codemonkey.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [patch] halt_on_oops command line option
Message-Id: <20060119154028.4f1347c5.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0601191520480.11660@shark.he.net>
References: <20060118232255.3814001b.akpm@osdl.org>
	<20060119073951.GC21663@redhat.com>
	<20060118235958.6b466a86.akpm@osdl.org>
	<20060119192654.GL21663@redhat.com>
	<20060119151805.1c4dc2af.akpm@osdl.org>
	<Pine.LNX.4.58.0601191520480.11660@shark.he.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rdunlap@xenotime.net> wrote:
>
> On Thu, 19 Jan 2006, Andrew Morton wrote:
> 
> > diff -puN Documentation/kernel-parameters.txt~pause_on_oops-command-line-option Documentation/kernel-parameters.txt
> > --- 25/Documentation/kernel-parameters.txt~pause_on_oops-command-line-option	Thu Jan 19 14:42:25 2006
> > +++ 25-akpm/Documentation/kernel-parameters.txt	Thu Jan 19 14:51:35 2006
> > @@ -544,6 +544,11 @@ running once the system is up.
> >
> >  	gvp11=		[HW,SCSI]
> >
> > +	pause_on_oops=
> > +			Halt all CPUs after the first oops has been printed for
> > +			the specified number of seconds.  This is to be used if
> > +			your oopses keep scrolling off the screen.
> > +
> >  	hashdist=	[KNL,NUMA] Large hashes allocated during boot
> >  			are distributed across NUMA nodes.  Defaults on
> >  			for IA-64, off otherwise.
> 
> Why there?

Coz I did s/halt_on_oops/pause_on_oops/ on the original patch ;)
