Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267252AbTBUI4b>; Fri, 21 Feb 2003 03:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267253AbTBUI4b>; Fri, 21 Feb 2003 03:56:31 -0500
Received: from w089.z209220022.nyc-ny.dsl.cnc.net ([209.220.22.89]:62994 "HELO
	yucs.org") by vger.kernel.org with SMTP id <S267252AbTBUI4a>;
	Fri, 21 Feb 2003 03:56:30 -0500
Subject: Re: hard lockup on 2.4.20 w/ nfs over frees/wan
From: Shaya Potter <spotter@cs.columbia.edu>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030220164420.GA9800@gtf.org>
References: <1045634189.4761.44.camel@zaphod>
	 <1045686971.8084.2.camel@zaphod> <1045757772.31762.13.camel@zaphod>
	 <20030220164420.GA9800@gtf.org>
Content-Type: text/plain
Organization: 
Message-Id: <1045818331.21281.20.camel@zaphod>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 21 Feb 2003 04:05:31 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-02-20 at 11:44, Jeff Garzik wrote:
> On Thu, Feb 20, 2003 at 11:16:13AM -0500, Shaya Potter wrote:
> > moved from the netfinity's onboard pcnet32 adapter to an IBM branded
> > Intel epro/100 w/ the intel driver in 2.4.20 and it appears very
> > stable.  Is it possible the pcnet/32 adapter is broken or the driver is
> > buggy?
> 
> I have gotten reports the 2.4.20 pcnet32 is buggy.
> 
> Can you test 2.4.20 with 2.4.19 version of pcnet32.c?

I'll do it at the beg. of next week, as I'm not going into the Lab
tomorrow.

I'm using 2 basically (as in have gotten serviced and parts replaced)
netfinity's.  1 seems to work perfectly well w/ the pcnet32 driver/card,
while the other one was having serious issue.  Strangely enough, I took
about a 10% hit in performance when I went from the "broken" pcnet32
card to the intel eepro 100 on my informal nfs benchmarks (at least for
the ones that would complete w/o hanging the computer)

