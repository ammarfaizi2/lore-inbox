Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751352AbWIURCw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbWIURCw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 13:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbWIURCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 13:02:51 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:18314 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751352AbWIURCu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 13:02:50 -0400
Date: Thu, 21 Sep 2006 22:32:26 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: sekharan@us.ibm.com, npiggin@suse.de, ckrm-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, rohitseth@google.com, menage@google.com,
       devel@openvz.org, clameter@sgi.com
Subject: Re: [ckrm-tech] [patch00/05]: Containers(V2)- Introduction
Message-ID: <20060921170226.GA7369@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <1158718568.29000.44.camel@galaxy.corp.google.com> <Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com> <1158777240.6536.89.camel@linuxchandra> <6599ad830609201143h19f6883wb388666e27913308@mail.google.com> <1158778496.6536.95.camel@linuxchandra> <20060920132734.69ab4f57.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060920132734.69ab4f57.pj@sgi.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2006 at 01:27:34PM -0700, Paul Jackson wrote:
> For other resources, such as CPU cycles and network bandwidth, unless
> another bright spark comes up with an insight, I don't see how to
> express the "percentage used" semantics provided by something such
> as CKRM, using anything resembling cpusets.

How abt metered cpusets? Each child cpuset of a metered cpuset
represents a fraction of CPU time alloted to the tasks of the child
cpuset.

> ... Can one imagine having the scheduler subdivide each second of
> time available on a CPU into several fake-CPUs, each one of which
> speaks for one of those sub-second fake-CPU slices?  Sounds too
> weird to me, and a bit too rigid to be a servicable CKRM substitute.

-- 
Regards,
vatsa
