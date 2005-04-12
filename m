Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263001AbVDLUyB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263001AbVDLUyB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 16:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262150AbVDLUob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 16:44:31 -0400
Received: from fire.osdl.org ([65.172.181.4]:59315 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262154AbVDLT7K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 15:59:10 -0400
Date: Tue, 12 Apr 2005 12:58:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com
Subject: Re: [patch 6/9] blk: unplug later
Message-Id: <20050412125859.209beead.akpm@osdl.org>
In-Reply-To: <425BC421.9010302@yahoo.com.au>
References: <425BC262.1070500@yahoo.com.au>
	<425BC421.9010302@yahoo.com.au>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> get_request_wait needn't unplug the device immediately.

Probably.  But what if the get_request(q, rw, GFP_NOIO); did
some sleeping?
