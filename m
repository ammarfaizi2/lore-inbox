Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263221AbUCNAFg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 19:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263223AbUCNAFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 19:05:36 -0500
Received: from holomorphy.com ([207.189.100.168]:33803 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263221AbUCNAFa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 19:05:30 -0500
Date: Sat, 13 Mar 2004 16:05:06 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andi Kleen <ak@suse.de>
Cc: Ray Bryant <raybry@sgi.com>, lse-tech@lists.sourceforge.net,
       "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: Hugetlbpages in very large memory machines.......
Message-ID: <20040314000506.GE655@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andi Kleen <ak@suse.de>, Ray Bryant <raybry@sgi.com>,
	lse-tech@lists.sourceforge.net,
	"linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
	linux-kernel@vger.kernel.org
References: <40528383.10305@sgi.com> <20040313034840.GF4638@wotan.suse.de> <20040313054910.GA655@holomorphy.com> <20040313161010.GB15118@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040313161010.GB15118@wotan.suse.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> That's not entirely true. Whether it's feasible depends on how the
>> MMU is used. The HPW (Hardware Pagetable Walker) and short mode of the
>> VHPT insist upon pagesize being a per-region attribute, where regions
>> are something like 60-bit areas of virtualspace, which is likely what
>> they're referring to. The VHPT in long mode should be capable of
>> arbitrary virtual placement (modulo alignment of course).

On Sat, Mar 13, 2004 at 05:10:10PM +0100, Andi Kleen wrote:
> Redesigning the low level TLB fault handling for this would not count as
> "easily" in my book.

I make no estimate of ease of implementation of long mode VHPT support.
The point of the above is that the virtual placement constraint is an
artifact of the implementation and not inherent in hardware.


-- wli
