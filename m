Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264136AbTCXHRN>; Mon, 24 Mar 2003 02:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264137AbTCXHRN>; Mon, 24 Mar 2003 02:17:13 -0500
Received: from holomorphy.com ([66.224.33.161]:58011 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S264136AbTCXHRN>;
	Mon, 24 Mar 2003 02:17:13 -0500
Date: Sun, 23 Mar 2003 23:27:59 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.65-mm4
Message-ID: <20030324072759.GH30140@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, Ingo Molnar <mingo@elte.hu>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030323191744.56537860.akpm@digeo.com> <Pine.LNX.4.44.0303240756010.1587-100000@localhost.localdomain> <20030323231716.44d7e306.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030323231716.44d7e306.akpm@digeo.com>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 23, 2003 at 11:17:16PM -0800, Andrew Morton wrote:
> In the case of ext2 the codepath which needs to be locked is very small, and
> converting it to use a per-blockgroup spinlock was a big win on the 16-way
> numas, and perhaps 8-way x440's.  On 4-way xeon and ppc64 the effects were
> very small indeed - 1.5% on xeon, zero on ppc64.

And also very large on 32x NUMA-Q.


-- wli
