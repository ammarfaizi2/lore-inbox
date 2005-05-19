Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261264AbVESVfl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261264AbVESVfl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 17:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261267AbVESVfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 17:35:40 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:48548 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S261264AbVESVfa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 17:35:30 -0400
X-ORBL: [63.205.185.30]
Date: Thu, 19 May 2005 14:35:22 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Steve Lord <lord@xfs.org>
Cc: Joshua Baker-LePain <jlb17@duke.edu>, Lee Revell <rlrevell@joe-job.com>,
       Gregory Brauer <greg@wildbrain.com>, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com, Jakob Oestergaard <jakob@unthought.net>
Subject: Re: kernel OOPS for XFS in xfs_iget_core (using NFS+SMP+MD)
Message-ID: <ee495a9b344cda2cab3ddbb7bdbfca4c.IBX@taniwha.stupidest.org>
References: <428B7D7F.9000107@wildbrain.com> <20050518175925.GA22738@taniwha.stupidest.org> <20050518195251.GY422@unthought.net> <Pine.LNX.4.58.0505181556410.6834@chaos.egr.duke.edu> <428BA8E4.2040108@wildbrain.com> <Pine.LNX.4.58.0505191537560.7094@chaos.egr.duke.edu> <Pine.LNX.4.58.0505191650580.7094@chaos.egr.duke.edu> <1116536963.23186.2.camel@mindpipe> <Pine.LNX.4.58.0505191713540.7094@chaos.egr.duke.edu> <428D0540.4000107@xfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <428D0540.4000107@xfs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2005 at 04:29:36PM -0500, Steve Lord wrote:
> Joshua Baker-LePain wrote:

> Does xfs_repair report anything after this has happened, it looks
> like it is trying to read a directory block up from disk to satisfy
> a lookup request and failing for some reason.

bit corruption?  bad hardware maybe?
