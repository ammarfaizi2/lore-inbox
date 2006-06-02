Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751096AbWFBCDU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbWFBCDU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 22:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbWFBCDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 22:03:19 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:28356 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751096AbWFBCDT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 22:03:19 -0400
Subject: Re: [ckrm-tech] sched: Add CPU rate hard caps
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Con Kolivas <kernel@kolivas.org>
Cc: Andrew Morton <akpm@osdl.org>, dev@openvz.org, Jens Axboe <axboe@suse.de>,
       Srivatsa <vatsa@in.ibm.com>, ckrm-tech@lists.sourceforge.net,
       balbir@in.ibm.com, Balbir Singh <bsingharora@gmail.com>,
       Mike Galbraith <efault@gmx.de>, Sam Vilain <sam@vilain.net>,
       Peter Williams <pwil3058@bigpond.net.au>,
       Kingsley Cheung <kingsley@aurema.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, Rene Herman <rene.herman@keyaccess.nl>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200606021036.17021.kernel@kolivas.org>
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest>
	 <447EA694.8060407@in.ibm.com> <1149187413.13336.24.camel@linuxchandra>
	 <200606021036.17021.kernel@kolivas.org>
Content-Type: text/plain
Organization: IBM
Date: Thu, 01 Jun 2006 19:03:14 -0700
Message-Id: <1149213794.10377.8.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-02 at 10:36 +1000, Con Kolivas wrote:
> On Friday 02 June 2006 04:43, Chandra Seetharaman wrote:
> > On Thu, 2006-06-01 at 14:04 +0530, Balbir Singh wrote:
> > > > - disk I/O bandwidth:
> > > > we started to use CFQv2, but it is quite poor in this regard. First, it
> > > > doesn't prioritizes writes and async disk operations :( And even for
> > > > sync reads we found some problems we work on now...
> >
> > CKRM (on e-series) had an implementation based on a modified CFQ
> > scheduler. Shailabh is currently working on porting that controller to
> > f-series.
> 
> I hope that the changes you have to improve CFQ were done in a way that is 
> suitable for mainline and you're planning to try and merge them there.

That is our #1 object :)
> 
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


