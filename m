Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261693AbUEFGex@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbUEFGex (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 02:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261718AbUEFGex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 02:34:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:25823 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261693AbUEFGew (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 02:34:52 -0400
Date: Wed, 5 May 2004 23:34:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: kenneth.w.chen@intel.com, linux-kernel@vger.kernel.org
Subject: Re: Cache queue_congestion_on/off_threshold
Message-Id: <20040505233426.704926da.akpm@osdl.org>
In-Reply-To: <20040506062028.GB10069@suse.de>
References: <200405052212.i45MC0F28121@unix-os.sc.intel.com>
	<20040506062028.GB10069@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:
>
> Do you have any numbers at all for this? I'd say these calculations are
>  severly into the noise area when submitting io.

The difference will not be measurable, but I think the patch makes sense
regardless of what the numbers say.

I uninlined the new function though.  Two callsites, both slowpath...
