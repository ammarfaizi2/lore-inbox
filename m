Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030332AbVLVWzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030332AbVLVWzG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 17:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030342AbVLVWzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 17:55:06 -0500
Received: from ns1.siteground.net ([207.218.208.2]:51174 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1030332AbVLVWzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 17:55:04 -0500
Date: Thu, 22 Dec 2005 14:55:03 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       shai@scalex86.org
Subject: Re: [patch] mm: Patch to convert global dirty_exceeded flag to per-node node_dirty_exceeded
Message-ID: <20051222225503.GA6416@localhost.localdomain>
References: <20051222223139.GC3704@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051222223139.GC3704@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2005 at 02:31:39PM -0800, Ravikiran G Thirumalai wrote:
> Patch to convert global dirty_exceeded flag to per-node
> node_dirty_exceeded.

This depends on the compile fix for node_to_fist_cpu I posted before 
if this code has to run on x86_64/ia64

http://marc.theaimsgroup.com/?l=linux-kernel&m=113529019215045&w=2

Thanks,
Kiran
