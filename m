Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267678AbUIOWBh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267678AbUIOWBh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 18:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267646AbUIOWAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 18:00:38 -0400
Received: from holomorphy.com ([207.189.100.168]:33183 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267618AbUIOWAX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 18:00:23 -0400
Date: Wed, 15 Sep 2004 15:00:16 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: andrea@novell.com, linux-kernel@vger.kernel.org, an.li.wang@intel.com
Subject: Re: truncate shows non zero data beyond the end of the inode with MAP_SHARED
Message-ID: <20040915220016.GC9106@holomorphy.com>
References: <20040915122920.GA4454@dualathlon.random> <20040915210106.GX9106@holomorphy.com> <20040915145524.079a8694.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040915145524.079a8694.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>> Zeroing the final partial page during expanding truncate (flushing TLB)
>> sounds like a reasonable half measure; we don't do anything at the moment.

On Wed, Sep 15, 2004 at 02:55:24PM -0700, Andrew Morton wrote:
> Sure about that?  block_truncate_page() gets called.

So it does; then the hard parts are what's biting aa.


-- wli
