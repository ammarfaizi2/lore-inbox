Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319025AbSHSVTl>; Mon, 19 Aug 2002 17:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319026AbSHSVTl>; Mon, 19 Aug 2002 17:19:41 -0400
Received: from holomorphy.com ([66.224.33.161]:6606 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S319025AbSHSVTk>;
	Mon, 19 Aug 2002 17:19:40 -0400
Date: Mon, 19 Aug 2002 14:22:35 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@zip.com.au,
       gone@us.ibm.com, Martin.Bligh@us.ibm.com
Subject: Re: 2.5.31 i386 mem_map usage corrections
Message-ID: <20020819212235.GC21683@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@zip.com.au,
	gone@us.ibm.com, Martin.Bligh@us.ibm.com
References: <20020819102156.GJ18350@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020819102156.GJ18350@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2002 at 03:21:56AM -0700, William Lee Irwin III wrote:
> With these fixes (modulo merging), most notably the fix for
> pmd_populate(), I was able to boot and run userspace on a 16x/16G NUMA-Q
> in combination with Pat Gaughen's x86 discontigmem patches.

In case this wasn't clear, this is a fix for what is (AFAIK)
the only reliably reproducible scenario reproducing the BUG on
page->pte.chain != NULL.


Cheers,
Bill
