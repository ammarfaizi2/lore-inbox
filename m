Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270911AbUJVEKx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270911AbUJVEKx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 00:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270948AbUJVEKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 00:10:35 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:13471 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S270911AbUJVEHy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 00:07:54 -0400
Subject: Re: [PATCH] I/O space write barrier
From: Greg Banks <gnb@melbourne.sgi.com>
To: Jesse Barnes <jbarnes@sgi.com>
Cc: Grant Grundler <iod00d@hp.com>, Jesse Barnes <jbarnes@engr.sgi.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, tony.luck@intel.com,
       linux-ia64@vger.kernel.org
In-Reply-To: <200410212205.51672.jbarnes@sgi.com>
References: <200410211613.19601.jbarnes@engr.sgi.com>
	 <20041022010150.GH3878@cup.hp.com>  <200410212205.51672.jbarnes@sgi.com>
Content-Type: text/plain
Organization: Silicon Graphics Inc, Australian Software Group.
Message-Id: <1098419164.21421.58.camel@hole.melbourne.sgi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 22 Oct 2004 14:26:05 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-22 at 13:05, Jesse Barnes wrote:
>  I think Greg had some ideas about other 
> things to cover as well.  Greg?

You've done most of the stuff I wanted, but it would be nice to see:

*  a mention of the read-to-flush-writes technique and why mmiowb
   is better

*  an example of how and where to use read_relaxed and a description
   of why its better than read

Greg.
-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.


