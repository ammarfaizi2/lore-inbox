Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261367AbVF1L4O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbVF1L4O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 07:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261391AbVF1L4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 07:56:14 -0400
Received: from wproxy.gmail.com ([64.233.184.196]:43729 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261367AbVF1L4M convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 07:56:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=iiE50x46rGEJzObmdvpJUAUKLJQGSMtZ58gJvv09R4k2r14xrMZC1G+L1avufmDpFjkIhZEIQ3FDGPv31/UdVj+GTuxshc4Bs4MRbhW34FSRdSQrV+IKgI42GI1rvXFuByvGO/LUyy2gSnH6ua5HqQJ3I9zOUptI2MwxF3zBCl8=
Message-ID: <3bba6cc4050628045676c61112@mail.gmail.com>
Date: Tue, 28 Jun 2005 17:26:10 +0530
From: David Kearster <david.kearster@gmail.com>
Reply-To: David Kearster <david.kearster@gmail.com>
To: nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: RE: [rfc] lockless pagecache
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi nick,

The patches that u posted on lkml regarding the vfs scalibility, on
which kernel did u build them.
I tried applying them on 2.6.12-git4, 2.6.12-mm1, mm2, 2.6.12.1, but
to no avail.

Many hunks are failing in each of the patch. I guess when the first is
failing others are
bound to..

Also, i m trying to apply the patches in the following order :
[patch 1] mm: PG_free flag
[patch 2] mm: speculative get_page
[patch 3] radix tree: lookup_slot
[patch 4] radix tree: lockless readside
[patch 5] mm: lockless pagecache lookups
[patch 6] mm: spinlock tree_lock

This sequence is correct....right?

Thanks,
Dave
