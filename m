Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030300AbVINX7R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030300AbVINX7R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 19:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030301AbVINX7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 19:59:16 -0400
Received: from pat.uio.no ([129.240.130.16]:28817 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1030300AbVINX7Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 19:59:16 -0400
Subject: Re: Bug#328135: kernel-image-2.6.11-1-686-smp: nfs reading process
	stuck in disk wait
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Horms <horms@debian.org>
Cc: Marc Horowitz <marc@mit.edu>, 328135@bugs.debian.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050914025150.GR27828@verge.net.au>
References: <20050913194707.8C8C28E6F0@ayer.connecterra.net>
	 <20050914025150.GR27828@verge.net.au>
Content-Type: text/plain
Date: Thu, 15 Sep 2005 00:58:55 +0100
Message-Id: <1126742335.8807.74.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.345, required 12,
	autolearn=disabled, RCVD_IN_NJABL_DUL 1.66,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

on den 14.09.2005 Klokka 11:51 (+0900) skreiv Horms:
> Hi Marc,
> 
> would is be possible to test linux-image-2.6.12-1-686-smp from 
> unstable to see if this problem persists? I am CCing the NFS
> maintainer and LKML as this looks reasonably nasty and they
> may be interested in looking into it.
> 

I doubt this has anything to do with NFS. We should no longer have a
sync_page VFS method in the 2.6 kernels. What other filesystems is the
user running?

Cheers,
  Trond

