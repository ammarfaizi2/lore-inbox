Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966586AbWKOFdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966586AbWKOFdm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 00:33:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966657AbWKOFdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 00:33:42 -0500
Received: from mx2.netapp.com ([216.240.18.37]:12392 "EHLO mx2.netapp.com")
	by vger.kernel.org with ESMTP id S966586AbWKOFdm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 00:33:42 -0500
X-IronPort-AV: i="4.09,423,1157353200"; 
   d="scan'208"; a="2610919:sNHT15748754"
Subject: Yet another borken page_count() check in
	invalidate_inode_pages2()....
From: Trond Myklebust <Trond.Myklebust@netapp.com>
To: Andrew Morton <akpm@osdl.org>, Charles Edward Lever <chucklever@gmail.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Network Appliance Inc
Date: Wed, 15 Nov 2006 00:33:39 -0500
Message-Id: <1163568819.5645.8.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
X-OriginalArrivalTime: 15 Nov 2006 05:33:40.0682 (UTC) FILETIME=[9B8762A0:01C70877]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm once again getting bogus errors from invalidate_inode_pages2() due
to a VM bug. See the third line of remove_mapping().

Cheers,
  Trond
