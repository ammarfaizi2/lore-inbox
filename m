Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261290AbTBOLji>; Sat, 15 Feb 2003 06:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261527AbTBOLji>; Sat, 15 Feb 2003 06:39:38 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:33289 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261290AbTBOLjh>; Sat, 15 Feb 2003 06:39:37 -0500
Date: Sat, 15 Feb 2003 11:49:31 +0000
From: Christoph Hellwig <hch@infradead.org>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: clean up SLAB_KERNEL non-usage
Message-ID: <20030215114931.A18281@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20030215114054.GA32256@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030215114054.GA32256@holomorphy.com>; from wli@holomorphy.com on Sat, Feb 15, 2003 at 03:40:54AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 15, 2003 at 03:40:54AM -0800, William Lee Irwin III wrote:
> Use SLAB_KERNEL and SLAB_ATOMIC instead of GFP_KERNEL and GFP_ATOMIC
> when passing args to slab allocation functions.

Why?  I'd prefer to completly get rid of the SLAB_ flags instead.

(stupid slowaris compat..)
