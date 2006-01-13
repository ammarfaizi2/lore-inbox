Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161571AbWAMVqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161571AbWAMVqT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 16:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161572AbWAMVqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 16:46:19 -0500
Received: from teetot.devrandom.net ([66.35.250.243]:474 "EHLO
	teetot.devrandom.net") by vger.kernel.org with ESMTP
	id S1161571AbWAMVqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 16:46:18 -0500
Date: Fri, 13 Jan 2006 13:56:09 -0800
From: thockin@hockin.org
To: David Lang <dlang@digitalinsight.com>
Cc: Lee Revell <rlrevell@joe-job.com>,
       Sven-Thorsten Dietrich <sven@mvista.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Dual core Athlons and unsynced TSCs
Message-ID: <20060113215609.GA30634@hockin.org>
References: <1137178855.15108.42.camel@mindpipe> <Pine.LNX.4.62.0601131315310.9821@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0601131315310.9821@qynat.qvtvafvgr.pbz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2006 at 01:18:35PM -0800, David Lang wrote:
> Lee, the last time I saw this discussion I thought it was identified that 
> the multiple cores (or IIRC the multiple chips in a SMP motherboard) would 
> only get out of sync when power management calls were made (hlt or 
> switching the c-state). IIRC the workaround that was posted then was to 
> just disable these in the kernel build.

not using 'hlt' when idling means that you spend 10s of Watts more power
on mostly idle systems.
