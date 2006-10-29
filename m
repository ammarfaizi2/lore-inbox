Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030366AbWJ2V6J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030366AbWJ2V6J (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 16:58:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030369AbWJ2V6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 16:58:09 -0500
Received: from mx2.netapp.com ([216.240.18.37]:22107 "EHLO mx2.netapp.com")
	by vger.kernel.org with ESMTP id S1030366AbWJ2V6I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 16:58:08 -0500
X-IronPort-AV: i="4.09,369,1157353200"; 
   d="scan'208"; a="422634576:sNHT15646480"
Subject: Re: [PATCH] nfs: Fix nfs_readpages() error path
From: Trond Myklebust <Trond.Myklebust@netapp.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       cluster-devel@redhat.com
In-Reply-To: <87pscaua7p.fsf@duaron.myhome.or.jp>
References: <877iyjundz.fsf@duaron.myhome.or.jp>
	 <1162149038.5545.37.camel@lade.trondhjem.org>
	 <87pscaua7p.fsf@duaron.myhome.or.jp>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Network Appliance Inc
Date: Sun, 29 Oct 2006 16:58:06 -0500
Message-Id: <1162159086.5545.70.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
X-OriginalArrivalTime: 29 Oct 2006 21:58:07.0182 (UTC) FILETIME=[50E246E0:01C6FBA5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-30 at 05:40 +0900, OGAWA Hirofumi wrote:
> Well, both seems right things for me. So, the patch was done by
> minimum change for -rc. If you want it, I'll do.

Feel free. I should have time to work on it tomorrow, in case you don't
find time today.

> BTW, umm.. now I think, gfs2_readpages() seems to have a bug in error
> path by different way. unlock_page() is really needed?

That looks like a definite bug too.

Cheers,
  Trond
