Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030200AbVKSAJF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030200AbVKSAJF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 19:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030266AbVKSAJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 19:09:05 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:32141 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1030200AbVKSAJE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 19:09:04 -0500
Date: Fri, 18 Nov 2005 16:08:55 -0800
From: Paul Jackson <pj@sgi.com>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC][PATCH 1/8] Create Critical Page Pool
Message-Id: <20051118160855.1ea249c8.pj@sgi.com>
In-Reply-To: <437E2D23.10109@us.ibm.com>
References: <437E2C69.4000708@us.ibm.com>
	<437E2D23.10109@us.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Total nit:

 #define __GFP_HARDWALL   ((__force gfp_t)0x40000u) /* Enforce hardwall cpuset memory allocs */
+#define __GFP_CRITICAL	((__force gfp_t)0x80000u) /* Critical allocation. MUST succeed! */

Looks like you used a space instead of a tab.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
