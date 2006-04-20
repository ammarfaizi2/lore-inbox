Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751246AbWDTUQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbWDTUQP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 16:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbWDTUQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 16:16:14 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:49073 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751246AbWDTUQN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 16:16:13 -0400
Date: Thu, 20 Apr 2006 15:16:08 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Tony Jones <tonyj@suse.de>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Stephen Smalley <sds@tycho.nsa.gov>,
       linux-security-module@vger.kernel.org, chrisw@sous-sol.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 11/11] security: AppArmor - Export namespace semaphore
Message-ID: <20060420201608.GA27183@sergelap.austin.ibm.com>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com> <20060419175034.29149.94306.sendpatchset@ermintrude.int.wirex.com> <1145536742.16456.35.camel@moss-spartans.epoch.ncsc.mil> <20060420124647.GD18604@sergelap.austin.ibm.com> <1145534735.3313.3.camel@moss-spartans.epoch.ncsc.mil> <20060420132128.GG18604@sergelap.austin.ibm.com> <20060420194503.GA1425@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060420194503.GA1425@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Tony Jones (tonyj@suse.de):
> On Thu, Apr 20, 2006 at 08:21:28AM -0500, Serge E. Hallyn wrote:
> 
> > Tony, do you have any performance measurements?  Both for unconfined and
> > confined apps?  Presumably unconfined processes should have 0 performance
> > hit, right?
> 
> Hi Serge.  
> 
> We have lmbench results.  We had issues getting reproducability out of dbench
> but need to look at it some more. The lmbench figures we presently have are 
> from the old code (reader writer lock).  Results were good but we recently 
> converted to rcu for the reader dominated rw locks.
> 
> I'm not sure there is "0 performance hit for unconfined" as you have to check
> for them being unconfined :) but it's low.
> 
> If you have other benchmarks we are open to suggestions. What has been used
> to benchmark SELinux?

I typically use dbench, reaim, tbench, and kernbench, running each 20
times.

> Anyways, we need to regenerate the results, we'll try and post in the next
> couple days.  ok?

Cool, thanks.

-serge
