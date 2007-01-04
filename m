Return-Path: <linux-kernel-owner+w=401wt.eu-S1030192AbXADTNt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030192AbXADTNt (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 14:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030194AbXADTNt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 14:13:49 -0500
Received: from extu-mxob-1.symantec.com ([216.10.194.28]:21123 "EHLO
	extu-mxob-1.symantec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030192AbXADTNs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 14:13:48 -0500
X-AuditID: d80ac21c-a047dbb00000021a-b5-459d51ec5ccf 
Date: Thu, 4 Jan 2007 19:14:04 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Hua Zhong <hzhong@gmail.com>
cc: Christoph Hellwig <hch@infradead.com>,
       "'Bill Davidsen'" <davidsen@tmr.com>,
       "'Linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: open(O_DIRECT) on a tmpfs?
In-Reply-To: <003f01c7302f$e72164b0$0200a8c0@nuitysystems.com>
Message-ID: <Pine.LNX.4.64.0701041911470.27405@blonde.wat.veritas.com>
References: <003f01c7302f$e72164b0$0200a8c0@nuitysystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 04 Jan 2007 19:13:47.0871 (UTC) FILETIME=[75F40EF0:01C73034]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jan 2007, Hua Zhong wrote:
> 
> So I'd argue that it makes more sense to support O_DIRECT
> on tmpfs as the memory IS the backing store.

A few more voices in favour and I'll be persuaded.  Perhaps I'm
out of date: when O_DIRECT came in, just a few filesystems supported
it, and it was perfectly normal for open O_DIRECT to be failed; but
I wouldn't want tmpfs to stand out now as a lone obstacle.

Christoph, what's your take on this?

Hugh
