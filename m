Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267563AbUHZEuK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267563AbUHZEuK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 00:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267542AbUHZEuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 00:50:09 -0400
Received: from holomorphy.com ([207.189.100.168]:42642 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267563AbUHZEt7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 00:49:59 -0400
Date: Wed, 25 Aug 2004 21:49:54 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Roland Dreier <roland@topspin.com>
Cc: jmerkey@comcast.net, linux-kernel@vger.kernel.org, jmerkey@drdos.com
Subject: Re: 1GB/2GB/3GB User Space Splitting Patch 2.6.8.1 (PSEUDO SPAM)
Message-ID: <20040826044954.GP2793@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Roland Dreier <roland@topspin.com>, jmerkey@comcast.net,
	linux-kernel@vger.kernel.org, jmerkey@drdos.com
References: <082620040421.9849.412D655C000690BA000026792200735446970A059D0A0306@comcast.net> <20040826043318.GO2793@holomorphy.com> <52isb6bj64.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52isb6bj64.fsf@topspin.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
William> ELF ABI violation. "...the reserved area shall not
William> consume more than 1GB of the address space."

On Wed, Aug 25, 2004 at 09:46:43PM -0700, Roland Dreier wrote:
> Agreed, but I do like running with PAGE_OFFSET == 0xB0000000 on my
> main box, which has 1 GB of RAM.  I can avoid highmem and still use
> the last 128 MB of RAM.  It takes me about 3 seconds to edit
> <asm/page.h> when I build a new kernel so I'm not arguing for merging
> this, though.

Though asinine, the ABI spec is set in stone.


-- wli
