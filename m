Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262316AbUDICmX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 22:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262389AbUDICmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 22:42:23 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:19945 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S262316AbUDICmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 22:42:22 -0400
Date: Thu, 8 Apr 2004 19:41:12 -0700
From: Wim Coekaerts <wim.coekaerts@oracle.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Hugh Dickins <hugh@veritas.com>, ak@suse.de, mbligh@aracnet.com,
       colpatch@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: NUMA API for Linux
Message-ID: <20040409024112.GP20863@ca-server1.us.oracle.com>
References: <20040407165639.2198b215.akpm@osdl.org> <Pine.LNX.4.44.0404081641450.7277-100000@localhost.localdomain> <20040408122543.670e1ad3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040408122543.670e1ad3.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ie: there are some (oracle) workloads where the kernel craps out due to
> lowmem vma exhaustion.  If they're now using remap_file_pages() for this then
> it may not be a problem any more.  Ingo would know better than I.

remap_file_pages() from now on yes.
