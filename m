Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261635AbSIXKNx>; Tue, 24 Sep 2002 06:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261636AbSIXKNx>; Tue, 24 Sep 2002 06:13:53 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:57003 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261635AbSIXKNw>;
	Tue, 24 Sep 2002 06:13:52 -0400
Date: Tue, 24 Sep 2002 15:54:28 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.38-mm2 [PATCH]
Message-ID: <20020924155428.B4085@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <3D8E96AA.C2FA7D8@digeo.com> <20020923151559.B29900@in.ibm.com> <20020924144109.2cbbdb36.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020924144109.2cbbdb36.rusty@rustcorp.com.au>; from rusty@rustcorp.com.au on Tue, Sep 24, 2002 at 02:41:09PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2002 at 02:41:09PM +1000, Rusty Russell wrote:
> On Mon, 23 Sep 2002 15:15:59 +0530
> Dipankar Sarma <dipankar@in.ibm.com> wrote:
> > Later I will submit a full rcu_ltimer patch that contains
> > the call_rcu_preempt() interface which can be useful for
> > module unloading and the likes. This doesn't affect
> > the non-preemption path.
> 
> You don't need this: I've dropped the requirement for module
> unload.

Isn't wait_for_later() similar to synchornize_kernel() or has the
entire module unloading design been changed since ?

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
