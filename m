Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261874AbTBOLy3>; Sat, 15 Feb 2003 06:54:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261907AbTBOLy2>; Sat, 15 Feb 2003 06:54:28 -0500
Received: from holomorphy.com ([66.224.33.161]:43653 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261874AbTBOLy1>;
	Sat, 15 Feb 2003 06:54:27 -0500
Date: Sat, 15 Feb 2003 04:03:24 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: clean up SLAB_KERNEL non-usage
Message-ID: <20030215120324.GG29983@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
References: <20030215114054.GA32256@holomorphy.com> <20030215114931.A18281@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030215114931.A18281@infradead.org>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 15, 2003 at 03:40:54AM -0800, William Lee Irwin III wrote:
>> Use SLAB_KERNEL and SLAB_ATOMIC instead of GFP_KERNEL and GFP_ATOMIC
>> when passing args to slab allocation functions.

On Sat, Feb 15, 2003 at 11:49:31AM +0000, Christoph Hellwig wrote:
> Why?  I'd prefer to completly get rid of the SLAB_ flags instead.
> (stupid slowaris compat..)

IMHO different API, different flags. The inverse is not that difficult
to produce, though.

-- wli
