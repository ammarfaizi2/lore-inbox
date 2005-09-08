Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751360AbVIHORn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbVIHORn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 10:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbVIHORn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 10:17:43 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:17867 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751360AbVIHORm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 10:17:42 -0400
Date: Thu, 8 Sep 2005 19:41:52 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Dinakar Guniguntala <dino@in.ibm.com>
Cc: Paul Jackson <pj@sgi.com>, KUROSAWA Takahiro <kurosawa@valinux.co.jp>,
       linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Subject: Re: [PATCH 0/5] SUBCPUSETS: a resource control functionality using CPUSETS
Message-ID: <20050908141152.GA11793@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20050908053912.1352770031@sv1.valinux.co.jp> <20050908002323.181fd7d5.pj@sgi.com> <20050908131427.GA5994@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050908131427.GA5994@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2005 at 06:44:27PM +0530, Dinakar Guniguntala wrote:
> 
> 
> > On the other hand, Dinakar had more work to do than you might, because
> > he needed a complete covering (so had to round up cpus in non exclusive
> > cpusets to form more covering elements).  From what I can tell, you
> > don't need a complete covering - it seems fine if some cpus are not
> > managed by this resource control function.
> 
> 
> I think it makes more sense to add this functionality directly as part
> of the existing cpusets instead of creating further leaf cpusets (or subcpusets
> as you call it) where we can specify resource control parameters. I think that 
> approach would be much more intuitive and simple to work with rather than 
> what you have currently. 

If what subcpusets is doing is slicing cpusets resources, then wouldn't
it be more intusive to call them slice0, slice1 etc. under the 
respective cpuset ?

Thanks
Dipankar
