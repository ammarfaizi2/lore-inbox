Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932185AbVKKHdD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbVKKHdD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 02:33:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbVKKHdD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 02:33:03 -0500
Received: from holomorphy.com ([66.93.40.71]:29911 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S932185AbVKKHdC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 02:33:02 -0500
Date: Thu, 10 Nov 2005 23:30:18 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Arun Sharma <arun.sharma@google.com>
Cc: Andrew Morton <akpm@osdl.org>, rohit.seth@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Expose SHM_HUGETLB in shmctl(id, IPC_STAT, ...)
Message-ID: <20051111073018.GS29402@holomorphy.com>
References: <20051109184623.GA21636@sharma-home.net> <20051109222223.538309e4.akpm@osdl.org> <43739302.1080404@google.com> <20051110115941.1cbe1ae7.akpm@osdl.org> <4373BE8D.2070104@google.com> <20051110140621.47729c5b.akpm@osdl.org> <437406D4.4060304@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <437406D4.4060304@google.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
>> But then again, if it was possible to write 100 lines of userspace code, we
>> wouldn't need this capability at all.  I bet if the userspace guys tried a
>> bit harder they'd work out a way of teaching their applications to remember
>> what they did.

On Thu, Nov 10, 2005 at 06:49:56PM -0800, Arun Sharma wrote:
> Why do we need shmctl(IPC_STAT) then? Applications should remember what 
> they did :)

atime, dtime, ctime, lpid, and nattch are not "rememberable" this way.


-- wli
