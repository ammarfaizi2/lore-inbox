Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbVAaMDN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbVAaMDN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 07:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261165AbVAaMDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 07:03:12 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:44231 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261162AbVAaMDK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 07:03:10 -0500
Date: Mon, 31 Jan 2005 04:02:45 -0800
From: Paul Jackson <pj@sgi.com>
To: Matt Mackall <mpm@selenic.com>
Cc: akpm@osdl.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] lib/sort: Replace open-coded O(pids**2) bubblesort
 in cpusets
Message-Id: <20050131040245.1c4bdb29.pj@sgi.com>
In-Reply-To: <6.416337461@selenic.com>
References: <5.416337461@selenic.com>
	<6.416337461@selenic.com>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt wrote:
> Eep. cpuset uses bubble sort on a data set that's potentially O(#
> processes). Switch to lib/sort.
> 
> Signed-off-by: Matt Mackall <mpm@selenic.com>

Acked-by: Paul Jackson <pj@sgi.com>

Ack'ing in principle -- the lib/sort patch itself still hasn't
arrived in my email inbox, so I can only trust that it does what
one would expect.  Assuming it does, then this cpuset patch seems
fine.

Thanks, Matt.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.650.933.1373, 1.925.600.0401
