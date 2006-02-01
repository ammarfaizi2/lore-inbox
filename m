Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161107AbWBAUUn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161107AbWBAUUn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 15:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161111AbWBAUUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 15:20:43 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:41905 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1161107AbWBAUUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 15:20:42 -0500
Subject: Re: 2.6.15-rt16
From: Lee Revell <rlrevell@joe-job.com>
To: Clark Williams <williams@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       chris perkins <cperkins@OCF.Berkeley.EDU>
In-Reply-To: <1138819142.18762.10.camel@localhost.localdomain>
References: <Pine.SOL.4.63.0601300839050.8546@conquest.OCF.Berkeley.EDU>
	 <1138640592.12625.0.camel@localhost.localdomain>
	 <Pine.SOL.4.63.0601300917120.8546@conquest.OCF.Berkeley.EDU>
	 <1138653235.26657.7.camel@localhost.localdomain>
	 <Pine.SOL.4.63.0601310946000.8770@conquest.OCF.Berkeley.EDU>
	 <1138730835.5959.3.camel@localhost.localdomain>
	 <1138818770.6685.1.camel@localhost.localdomain>
	 <1138819142.18762.10.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 01 Feb 2006 15:20:36 -0500
Message-Id: <1138825237.27434.78.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-01 at 12:39 -0600, Clark Williams wrote:
> On Wed, 2006-02-01 at 13:32 -0500, Steven Rostedt wrote:
> > 
> > I'm still curious to what's happening with your kernel.  I'm currently
> > running my x86_64 (typing right now on it) with CONFIG_SMP=n and
> > CONFIG_LATENCY=y.  I know you probably sent a config before, but could
> > you send it to me again.  (probably best to send it to me off list)
> 
> yeah, it's been gnawing at me too. Not really stopping me, but I've seen
> it happen on two Athlon64's (3000+ and 3400+). 
> 
> I'll send the .config offlist.
> 

Another thing to try is the broken out latency tracing patch, maybe the
bug is somewhere else in -rt:

http://people.redhat.com/mingo/latency-tracing-patches/latency-tracing-patches-2.6.15-rc7.tar.gz

This applies to 2.6.15 final and can easily be applied to 2.6.16-rc1.

Lee

