Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbWFBAiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbWFBAiM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 20:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWFBAiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 20:38:12 -0400
Received: from mail10.syd.optusnet.com.au ([211.29.132.191]:9633 "EHLO
	mail10.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750732AbWFBAiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 20:38:11 -0400
From: Con Kolivas <kernel@kolivas.org>
To: sekharan@us.ibm.com
Subject: Re: sched: Add CPU rate hard caps
Date: Fri, 2 Jun 2006 10:36:15 +1000
User-Agent: KMail/1.9.1
Cc: balbir@in.ibm.com, dev@openvz.org, Andrew Morton <akpm@osdl.org>,
       Srivatsa <vatsa@in.ibm.com>, Sam Vilain <sam@vilain.net>,
       ckrm-tech@lists.sourceforge.net, Balbir Singh <bsingharora@gmail.com>,
       Mike Galbraith <efault@gmx.de>,
       Peter Williams <pwil3058@bigpond.net.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Kingsley Cheung <kingsley@aurema.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, Rene Herman <rene.herman@keyaccess.nl>,
       Jens Axboe <axboe@suse.de>
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest> <447EA694.8060407@in.ibm.com> <1149187413.13336.24.camel@linuxchandra>
In-Reply-To: <1149187413.13336.24.camel@linuxchandra>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606021036.17021.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 02 June 2006 04:43, Chandra Seetharaman wrote:
> On Thu, 2006-06-01 at 14:04 +0530, Balbir Singh wrote:
> > > - disk I/O bandwidth:
> > > we started to use CFQv2, but it is quite poor in this regard. First, it
> > > doesn't prioritizes writes and async disk operations :( And even for
> > > sync reads we found some problems we work on now...
>
> CKRM (on e-series) had an implementation based on a modified CFQ
> scheduler. Shailabh is currently working on porting that controller to
> f-series.

I hope that the changes you have to improve CFQ were done in a way that is 
suitable for mainline and you're planning to try and merge them there.

-- 
-ck
