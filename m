Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263277AbTFGREX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 13:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263285AbTFGREW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 13:04:22 -0400
Received: from holomorphy.com ([66.224.33.161]:30919 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263277AbTFGREW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 13:04:22 -0400
Date: Sat, 7 Jun 2003 10:16:57 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ren? Scharfe <l.s.r@web.de>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       trivial@rustcorp.com.au
Subject: Re: [PATCH] hugetlbfs: fix error reporting in case of invalid mount options
Message-ID: <20030607171657.GH8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ren? Scharfe <l.s.r@web.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
References: <20030607145532.2bc66f38.l.s.r@web.de> <20030607163521.GG8978@holomorphy.com> <20030607192927.3d308201.l.s.r@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030607192927.3d308201.l.s.r@web.de>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Jun 2003 09:35:21 -0700 William Lee Irwin III <wli@holomorphy.com> wrote:
>> Let's nuke it entirely. All other fs's barf without printk()'ing at all
>> and kick -EINVAL back to the caller.

On Sat, Jun 07, 2003 at 07:29:27PM +0200, Ren? Scharfe wrote:
> Mmmkay, even better. Patch below.

Looks good to me. Linus, please apply.


-- wli
