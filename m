Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263180AbTCSXLe>; Wed, 19 Mar 2003 18:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263183AbTCSXLe>; Wed, 19 Mar 2003 18:11:34 -0500
Received: from spc1.esa.lanl.gov ([128.165.67.191]:20864 "EHLO
	spc1.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S263180AbTCSXLc>; Wed, 19 Mar 2003 18:11:32 -0500
Subject: Re: 2.5.65-mm2
From: "Steven P. Cole" <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: Robert Love <rml@tech9.net>
Cc: jjs <jjs@tmsusa.com>, linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1048115072.775.108.camel@phantasy.awol.org>
References: <20030319012115.466970fd.akpm@digeo.com>
	 <1048103489.1962.87.camel@spc9.esa.lanl.gov>
	 <20030319121055.685b9b8c.akpm@digeo.com>
	 <1048107434.1743.12.camel@spc1.esa.lanl.gov>
	 <1048111359.1807.13.camel@spc1.esa.lanl.gov>  <3E78EC63.9050308@tmsusa.com>
	 <1048114307.1511.12.camel@spc1.esa.lanl.gov>
	 <1048115072.775.108.camel@phantasy.awol.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048115944.1510.16.camel@spc1.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2-1mdk 
Date: 19 Mar 2003 16:19:04 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-03-19 at 16:04, Robert Love wrote:
> On Wed, 2003-03-19 at 17:51, Steven P. Cole wrote:
> 
> > I'll try the different value of max_timeslice with dbench on
> > reiserfs next.  That's where the lack of response was most evident.
> 
> I am curious as to whether reverting sched-D4 fixes this.
> 
> If not, the first step is seeing whether this is a bad decision made by
> the interactivity estimator.  Something like:
> 
> 	ps -eo pid,nice,priority,command
> 
> for dbench, evolution, and X might be useful.
> 
> Thanks,
> 
> 	Robert Love
> 
In the meantime, Andrew has asked me to revert the sched-D3 patch.  I'm
recompiling now, and will only have time for that test before I have to
go do other things.

Steven
