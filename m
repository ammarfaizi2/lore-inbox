Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263116AbUKTEHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263116AbUKTEHE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 23:07:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263126AbUKTEHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 23:07:00 -0500
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:29521 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263116AbUKTEGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 23:06:17 -0500
Message-ID: <419EC2AC.90308@yahoo.com.au>
Date: Sat, 20 Nov 2004 15:06:04 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Linus Torvalds <torvalds@osdl.org>, Christoph Lameter <clameter@sgi.com>,
       akpm@osdl.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Hugh Dickins <hugh@veritas.com>, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch V11 [0/7]: overview
References: <Pine.LNX.4.58.0411181715280.834@schroedinger.engr.sgi.com> <419D581F.2080302@yahoo.com.au> <Pine.LNX.4.58.0411181835540.1421@schroedinger.engr.sgi.com> <419D5E09.20805@yahoo.com.au> <Pine.LNX.4.58.0411181921001.1674@schroedinger.engr.sgi.com> <1100848068.25520.49.camel@gaston> <Pine.LNX.4.58.0411190704330.5145@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0411191155180.2222@ppc970.osdl.org> <20041120020306.GA2714@holomorphy.com> <419EBBE0.4010303@yahoo.com.au> <20041120035510.GH2714@holomorphy.com> <419EC205.5030604@yahoo.com.au>
In-Reply-To: <419EC205.5030604@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> William Lee Irwin III wrote:

>> And thread groups can share mm's. do_for_each_thread() won't suffice.
>>
> 
> I think it will be just fine.
> 

Sorry, I misread. I think having per-thread rss counters will be
fine (regardless of whether or not do_for_each_thread itself will
suffice).
