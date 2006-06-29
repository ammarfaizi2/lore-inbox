Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932744AbWF2VfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932744AbWF2VfF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 17:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932745AbWF2VfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 17:35:05 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:21198 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932744AbWF2VfD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 17:35:03 -0400
Date: Thu, 29 Jun 2006 14:35:41 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Dipankar Sarma <dipankar@in.ibm.com>, linux-kernel@vger.kernel.org,
       Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
       Prasanna Panchamukhi <prasanna@in.ibm.com>
Subject: Re: [PATCH] 2.6.17-rt1 : fix x86_64 oops
Message-ID: <20060629213541.GH1294@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060627200105.GA13966@in.ibm.com> <20060628182137.GA23979@in.ibm.com> <20060628193256.GA4392@elte.hu> <20060628200247.GA7932@in.ibm.com> <20060629142442.GA11546@elte.hu> <20060629163236.GD1294@us.ibm.com> <20060629194145.GA2327@us.ibm.com> <20060629201144.GA24287@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060629201144.GA24287@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2006 at 10:11:45PM +0200, Ingo Molnar wrote:
> 
> * Paul E. McKenney <paulmck@us.ibm.com> wrote:
> 
> > > This was on i386, x86_64, or on something else?
> > > 
> > > Ah!  This would have been a CONFIG_PREEMPT build, right?
> > 
> > OK, I ran this with both torture types (rcu and rcu_bh) on i386 with 
> > CONFIG_PREEMPT=y on 2.6.17-mm4 and didn't see any "scheduling while 
> > atomic" oopses -- or any other oopses, for that matter.
> > 
> > Here is the .config file I used.  What am I missing here?
> 
> hm, i'm seeing some other types of crashes too - so rcutorture could 
> just have been collateral damage. It was on i386, an allyesconfig 
> bzImage kernel.

Thanks for the info -- I will consider rcutorture free from suspicion
until you tell me otherwise.  ;-)

						Thanx, Paul
