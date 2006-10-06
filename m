Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932645AbWJFWTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932645AbWJFWTu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 18:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932648AbWJFWTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 18:19:50 -0400
Received: from mx2.netapp.com ([216.240.18.37]:40255 "EHLO mx2.netapp.com")
	by vger.kernel.org with ESMTP id S932645AbWJFWTt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 18:19:49 -0400
X-IronPort-AV: i="4.09,273,1157353200"; 
   d="dif'208?scan'208,208"; a="415723543:sNHT1358472600"
Subject: Re: [PATCH] VM: Fix the gfp_mask in invalidate_complete_page2
From: Trond Myklebust <Trond.Myklebust@netapp.com>
To: Steve Dickson <SteveD@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1160172990.12253.14.camel@lade.trondhjem.org>
References: <1160170629.5453.34.camel@lade.trondhjem.org>
	 <4526CF6F.9040006@RedHat.com>
	 <1160172990.12253.14.camel@lade.trondhjem.org>
Content-Type: multipart/mixed; boundary="=-NzKveN/26H8fgIw4FJ23"
Organization: Network Appliance Inc
Date: Fri, 06 Oct 2006 18:19:27 -0400
Message-Id: <1160173167.12253.17.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
X-OriginalArrivalTime: 06 Oct 2006 22:19:43.0192 (UTC) FILETIME=[85DD7580:01C6E995]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-NzKveN/26H8fgIw4FJ23
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2006-10-06 at 18:16 -0400, Trond Myklebust wrote:
> Yeah using mapping_gfp_mask(mapping) sounds like a better option.

Revised patch is attached...

Cheers,
  Trond


--=-NzKveN/26H8fgIw4FJ23
Content-Disposition: inline; filename*0=linux-2.6.18-005-fix_gfp_mask_in_invalidate_complete_page2.di; filename*1=f
Content-Type: message/rfc822; name=linux-2.6.18-005-fix_gfp_mask_in_invalidate_complete_page2.dif

From: Trond Myklebust <Trond.Myklebust@netapp.com>
Date: Fri Oct 6 17:31:47 2006 -0400
Subject: [PATCH] VM: Fix the gfp_mask in invalidate_complete_page2 
Note: I am less sure of what the callers of invalidate_inode_pages()
Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
Message-Id: <1160173167.12253.18.camel@lade.trondhjem.org>
Mime-Version: 1.0


--=-NzKveN/26H8fgIw4FJ23--
