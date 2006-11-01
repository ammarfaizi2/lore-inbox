Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946746AbWKAJ63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946746AbWKAJ63 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 04:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946749AbWKAJ62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 04:58:28 -0500
Received: from mx3.cs.washington.edu ([128.208.3.132]:13023 "EHLO
	mx3.cs.washington.edu") by vger.kernel.org with ESMTP
	id S1946746AbWKAJ61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 04:58:27 -0500
Date: Wed, 1 Nov 2006 01:58:15 -0800 (PST)
From: David Rientjes <rientjes@cs.washington.edu>
To: Paul Jackson <pj@sgi.com>
cc: menage@google.com, dev@openvz.org, vatsa@in.ibm.com, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, matthltc@us.ibm.com, dipankar@in.ibm.com,
       rohitseth@google.com
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
In-Reply-To: <20061101015030.451b7a86.pj@sgi.com>
Message-ID: <Pine.LNX.4.64N.0611010154290.32554@attu4.cs.washington.edu>
References: <20061030103356.GA16833@in.ibm.com>
 <6599ad830610300251w1f4e0a70ka1d64b15d8da2b77@mail.gmail.com>
 <20061030031531.8c671815.pj@sgi.com> <6599ad830610300404v1e036bb7o7ed9ec0bc341864e@mail.gmail.com>
 <20061030042714.fa064218.pj@sgi.com> <6599ad830610300953o7cbf5a6cs95000e11369de427@mail.gmail.com>
 <20061030123652.d1574176.pj@sgi.com> <6599ad830610301247k179b32f5xa5950d8fc5a3926c@mail.gmail.com>
 <Pine.LNX.4.64N.0610311951280.7538@attu4.cs.washington.edu>
 <20061101015030.451b7a86.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Nov 2006, Paul Jackson wrote:

> David wrote:
> >  - While the process containers are only single-level, the controllers are
> >    _inherently_ hierarchial just like a filesystem.  So it appears that
> 
> Cpusets certainly enjoys what I would call hierarchical process
> containers.  I can't tell if your flat container space is just
> a "for instance", or you're recommending we only have a flat
> container space.
> 

This was using the recommendation of "each process belongs to a single 
container that can be attached to controller nodes later."  So while it is 
indeed possible for the controllers, whatever they are, to be hierarchical 
(and most assuredly should be), what is the objection against grouping 
processes in single-level containers?  The only difference is that now 
when we assign processes to specific controllers with their attributes set 
as we desire, we are assigning a container (or group) processes instead of 
individual ones.

		David
