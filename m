Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266161AbUGOJgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266161AbUGOJgN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 05:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266169AbUGOJgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 05:36:13 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:19100 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266161AbUGOJgM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 05:36:12 -0400
Date: Thu, 15 Jul 2004 15:06:00 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Refcounting of objects part of a lockfree collection
Message-ID: <20040715093600.GB3952@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20040714045345.GA1220@obelix.in.ibm.com> <20040714070700.GA12579@kroah.com> <20040714085758.GA4165@obelix.in.ibm.com> <20040714170800.GC4636@kroah.com> <20040715080204.GC1312@obelix.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040715080204.GC1312@obelix.in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2004 at 01:32:04PM +0530, Ravikiran G Thirumalai wrote:
> The naming is bad, I agree. But as Dipankar pointed out earlier, there
> was no kref when I did this.  We (Dipankar and myslef) had a discussion
> and decided:
> 1. I will make a patch to shrink kref and feed it to Greg

1.5 Convert files_struct to use kref


> 2. Add new set kref api for lockfree refcounting --
> 	kref_lf_xxx.  (kref_lf_get, kref_lf_get_rcu etc.,)
> 3. Change the fd lookup patch to use kref_lf_xxx api

Thanks
Dipankar
