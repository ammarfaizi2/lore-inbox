Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265211AbSIWJAN>; Mon, 23 Sep 2002 05:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265216AbSIWJAN>; Mon, 23 Sep 2002 05:00:13 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:16322 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S265211AbSIWJAM>; Mon, 23 Sep 2002 05:00:12 -0400
Date: Mon, 23 Sep 2002 14:40:55 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.38 vs. 2.5.38-mm1 dbench 512 oprofiles
Message-ID: <20020923144055.A29900@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20020923053600.GJ25605@holomorphy.com> <20020923054604.GY3530@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020923054604.GY3530@holomorphy.com>; from wli@holomorphy.com on Mon, Sep 23, 2002 at 06:02:15AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2002 at 06:02:15AM +0000, William Lee Irwin III wrote:
> On Sun, Sep 22, 2002 at 10:36:00PM -0700, William Lee Irwin III wrote:
> sorry real 2.5.38-mm1 profile:
> c01053dc 884615995 93.5551     poll_idle
> c0114c28 38573436 4.07944     load_balance

Any idea why scheduler time shoot up with mm1 ? The RCU core
patch (rcu_ltimer) in mm1 doesn't force any context switches, so it
can't be that.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
