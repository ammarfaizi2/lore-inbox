Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263085AbUDATcV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 14:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262770AbUDATaD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 14:30:03 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:21124 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263085AbUDAT3d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 14:29:33 -0500
From: Jesse Barnes <jbarnes@sgi.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc1-mm2
Date: Thu, 1 Apr 2004 11:28:54 -0800
User-Agent: KMail/1.6.1
Cc: Andrew Morton <akpm@osdl.org>
References: <20040317201454.5b2e8a3c.akpm@osdl.org> <200403311515.01289.jbarnes@sgi.com> <20040331155626.3f196a18.akpm@osdl.org>
In-Reply-To: <20040331155626.3f196a18.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404011128.54499.jbarnes@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 31 March 2004 3:56 pm, Andrew Morton wrote:
> Could you also punt me over the .config?  If I can make it happen, the
> binary search will find it.  But it probably won't happen here.

CONFIG_HUGETLBFS is the culprit.  I'm trying to narrow it down to a specific 
hugetlb related patch now.

Jesse
