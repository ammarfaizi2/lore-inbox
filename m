Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932501AbVKWDpl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932501AbVKWDpl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 22:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932502AbVKWDpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 22:45:41 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:44747 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932501AbVKWDpl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 22:45:41 -0500
Date: Tue, 22 Nov 2005 19:45:13 -0800
From: Paul Jackson <pj@sgi.com>
To: Mel Gorman <mel@csn.ul.ie>
Cc: linux-mm@kvack.org, mel@csn.ul.ie, nickpiggin@yahoo.com.au, ak@suse.de,
       linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net,
       mingo@elte.hu
Subject: Re: [PATCH 1/5] Light fragmentation avoidance without usemap:
 001_antidefrag_flags
Message-Id: <20051122194513.3883d135.pj@sgi.com>
In-Reply-To: <20051122191715.21757.82818.sendpatchset@skynet.csn.ul.ie>
References: <20051122191710.21757.67440.sendpatchset@skynet.csn.ul.ie>
	<20051122191715.21757.82818.sendpatchset@skynet.csn.ul.ie>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

+#define __GFP_EASYRCLM   ((__force gfp_t)0x40000u) /* Easily reclaimed page */

Acked (this one line) by pj <grin>.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
