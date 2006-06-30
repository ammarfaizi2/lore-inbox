Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbWF3PDB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbWF3PDB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 11:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbWF3PDB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 11:03:01 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:51643 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750718AbWF3PDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 11:03:00 -0400
Subject: Re: [2.6 patch] let CONFIG_SECCOMP default to n
From: Lee Revell <rlrevell@joe-job.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Andrew Morton <akpm@osdl.org>, bunk@stusta.de,
       linux-kernel@vger.kernel.org, mingo@elte.hu
In-Reply-To: <20060629193525.af983237.rdunlap@xenotime.net>
References: <20060629192121.GC19712@stusta.de>
	 <1151628246.22380.58.camel@mindpipe>
	 <20060629180706.64a58f95.akpm@osdl.org>
	 <20060629193525.af983237.rdunlap@xenotime.net>
Content-Type: text/plain
Date: Fri, 30 Jun 2006 11:03:00 -0400
Message-Id: <1151679780.32444.21.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-29 at 19:35 -0700, Randy.Dunlap wrote:
> On Thu, 29 Jun 2006 18:07:06 -0700 Andrew Morton wrote:
> 
> > Lee Revell <rlrevell@joe-job.com> wrote:
> > >
> > > On Thu, 2006-06-29 at 21:21 +0200, Adrian Bunk wrote:
> > > > This patch was already sent on:
> > > > - 26 Jun 2006
> > > > - 27 Apr 2006
> > > > - 19 Apr 2006
> > > > - 11 Apr 2006
> > > > - 10 Mar 2006
> > > > - 29 Jan 2006
> > > > - 21 Jan 2006 
> > > 
> > > 3 days ago?  That seems a bit silly.  Why didn't you just ping Andrew on
> > > it?
> > > 
> > > Andrew, what's the status of this?  Can we get an ACK or a NACK before
> > > this starts getting reposted every day? ;-)
> > > 
> > 
> > I am stolidly letting the arch maintainers and the developer of this
> > feature work out what to do.
> 
> Bah, options that are not Required should default to n.
> I support Adrian's patch.

Agreed:

- Most people don't use it
- There's a performance hit

Clearly should default to N.

Lee

