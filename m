Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbUGLTfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbUGLTfS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 15:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbUGLTfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 15:35:18 -0400
Received: from holomorphy.com ([207.189.100.168]:18576 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261563AbUGLTfO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 15:35:14 -0400
Date: Mon, 12 Jul 2004 12:35:10 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] hugetlbfs private mappings.
Message-ID: <20040712193510.GH21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>,
	David Gibson <david@gibson.dropbear.id.au>
References: <40F139BA.F1F10B22@tv-sign.ru> <20040712001502.GS21066@holomorphy.com> <40F27FE6.A7E4FD96@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40F27FE6.A7E4FD96@tv-sign.ru>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> This probably doesn't break anything worth caring about, but it may
>> make people happier to just force MAP_SHARED on.

On Mon, Jul 12, 2004 at 04:11:18PM +0400, Oleg Nesterov wrote:
> Yes, it was my initial intent. Andrew Morton pointed out, that
> this could break existing applications.

I see; I thought the concern went the other direction. All's well, then.


-- wli
