Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264693AbUESXpw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264693AbUESXpw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 19:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264697AbUESXpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 19:45:52 -0400
Received: from mail8.fw-bc.sony.com ([160.33.98.75]:60125 "EHLO
	mail8.fw-bc.sony.com") by vger.kernel.org with ESMTP
	id S264693AbUESXpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 19:45:50 -0400
Message-ID: <40ABF1C0.1010804@am.sony.com>
Date: Wed, 19 May 2004 16:46:08 -0700
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Christoph Hellwig <hch@infradead.org>,
       Mark Gross <mgross@linux.jf.intel.com>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: ANNOUNCE: CE Linux Forum - Specification V1.0 draft
References: <40A90D00.7000005@am.sony.com> <20040517201910.A1932@infradead.org> <200405171342.49891.mgross@linux.intel.com> <20040518074854.A7348@infradead.org> <40ABB5E2.3040908@am.sony.com> <20040519225729.A28893@flint.arm.linux.org.uk>
In-Reply-To: <20040519225729.A28893@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Wed, May 19, 2004 at 12:30:42PM -0700, Tim Bird wrote:
> 
>>The non-normative section of this spec. explains where this was
>>a problem in 2.4, and why it is desirable, from the standpoint of
>>bootup time reduction, to avoid these busywaits.
> 
> In this case, it's really a bug that IDE is using a busy wait where it
> should be using a sleeping wait.  It's a bug, plain and simple.  To
> wrap the bug into "a spec" somehow seems wrong to me, especially when
> it would be far better to report the problem as a bug.

Sometimes it's difficult to discern what the intention or correctness
of a piece of code is, when you have limited experience with the code.
I know, we could have just asked...

> 
> Sure, specs make suit-wearing people happy, but that doesn't mean that
> they're appropriate as a bug reporting method. 8)

Agreed.  :-)  We should probably mutate this into a more general
statement that says "busywaits are not appreciated as a delay mechanism
by drivers on bootup."

=============================
Tim Bird
Architecture Group Co-Chair
CE Linux Forum
Senior Staff Engineer
Sony Electronics
E-mail: Tim.Bird@am.sony.com
=============================

