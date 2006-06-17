Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751042AbWFQI6i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbWFQI6i (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 04:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbWFQI6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 04:58:38 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:49071 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750758AbWFQI6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 04:58:37 -0400
Date: Sat, 17 Jun 2006 17:58:33 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: ak@suse.de, ashok.raj@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] avoid cpu hot remove of cpus which have special RT
 tasks.
Message-Id: <20060617175833.4f2b5cf3.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <4493C1FB.802@yahoo.com.au>
References: <20060616162343.02c3ce62.kamezawa.hiroyu@jp.fujitsu.com>
	<p7364j1qx66.fsf@verdi.suse.de>
	<20060616192654.50f4f6b7.kamezawa.hiroyu@jp.fujitsu.com>
	<200606161236.50302.ak@suse.de>
	<44937B16.3050204@yahoo.com.au>
	<20060617141216.dba310af.kamezawa.hiroyu@jp.fujitsu.com>
	<4493AF5C.4080600@yahoo.com.au>
	<20060617165319.458d913a.kamezawa.hiroyu@jp.fujitsu.com>
	<4493C1FB.802@yahoo.com.au>
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Jun 2006 18:48:59 +1000
Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> KAMEZAWA Hiroyuki wrote:

> > So, I think "stop mis-configurated process" can be one way for handling  such apps.
> > 
> > For example)
> > After exchanging broken cpu, the application can continue its work with the
> > same # of cpus.
> 
> OK I can see what you're trying to achieve, but I don't know that it is
> worthwhile. Userspace is doing something wrong, and it isn't normally the
> kernel's job to detect that.
> 
> When something like this comes up, sticking to the simplest semantics is
> often best.
> 
> That said, it isn't a great deal of code to maintain, and not "incorrect"
> as such. So if you convince Ingo to pick it up, I wouldn't complain.
> 
Thank you for discussing.
I'll rewrite text in the patch to reflect my point clearer.
and post again

Regards,
-Kame

