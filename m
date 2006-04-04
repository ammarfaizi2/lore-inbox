Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751824AbWDDGuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751824AbWDDGuQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 02:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751828AbWDDGuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 02:50:16 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:27056 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751824AbWDDGuP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 02:50:15 -0400
Date: Tue, 4 Apr 2006 08:50:22 +0200
From: Jens Axboe <axboe@suse.de>
To: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: potential null dereference in splice code.
Message-ID: <20060404065022.GJ4647@suse.de>
References: <20060403235206.GA31397@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060403235206.GA31397@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03 2006, Dave Jones wrote:
> We can get to out: with a NULL page, which we probably
> don't want to be calling page_cache_release() on.

Thanks Dave, applied.

-- 
Jens Axboe

