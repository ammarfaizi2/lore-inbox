Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261258AbVESVQN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbVESVQN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 17:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbVESVQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 17:16:13 -0400
Received: from chaos.egr.duke.edu ([152.3.195.82]:62851 "EHLO
	chaos.egr.duke.edu") by vger.kernel.org with ESMTP id S261258AbVESVQH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 17:16:07 -0400
Date: Thu, 19 May 2005 17:16:03 -0400 (EDT)
From: Joshua Baker-LePain <jlb17@duke.edu>
X-X-Sender: jlb@chaos.egr.duke.edu
To: Lee Revell <rlrevell@joe-job.com>
cc: Gregory Brauer <greg@wildbrain.com>, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com, Jakob Oestergaard <jakob@unthought.net>,
       Chris Wedgwood <cw@f00f.org>
Subject: Re: kernel OOPS for XFS in xfs_iget_core (using NFS+SMP+MD)
In-Reply-To: <1116536963.23186.2.camel@mindpipe>
Message-ID: <Pine.LNX.4.58.0505191713540.7094@chaos.egr.duke.edu>
References: <428511F8.6020303@wildbrain.com>  <20050514184711.GA27565@taniwha.stupidest.org>
  <428B7D7F.9000107@wildbrain.com>  <20050518175925.GA22738@taniwha.stupidest.org>
  <20050518195251.GY422@unthought.net>  <Pine.LNX.4.58.0505181556410.6834@chaos.egr.duke.edu>
  <428BA8E4.2040108@wildbrain.com>  <Pine.LNX.4.58.0505191537560.7094@chaos.egr.duke.edu>
  <Pine.LNX.4.58.0505191650580.7094@chaos.egr.duke.edu> <1116536963.23186.2.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 May 2005 at 5:09pm, Lee Revell wrote

> On Thu, 2005-05-19 at 17:00 -0400, Joshua Baker-LePain wrote:
> > May 19 16:47:10 norbert kernel: Filesystem "md0": XFS internal error xfs_da_do_buf(1) at line 2176 of file fs/xfs/xfs_da_btree.c.  Caller 0xf8c90148
*snip*
> 
> Couldn't this be a stack overflow?  That's a very large kernel stack.

I am using 8K stacks, and that's all the kernel messages I see.

-- 
Joshua Baker-LePain
Department of Biomedical Engineering
Duke University
