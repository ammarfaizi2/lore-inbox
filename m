Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264610AbUESWDN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264610AbUESWDN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 18:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264614AbUESWDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 18:03:13 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15061 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264610AbUESWDI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 18:03:08 -0400
Message-ID: <40ABD98F.9080505@pobox.com>
Date: Wed, 19 May 2004 18:02:55 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Tim Bird <tim.bird@am.sony.com>, Christoph Hellwig <hch@infradead.org>,
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
> 
> In this case, it's really a bug that IDE is using a busy wait where it
> should be using a sleeping wait.  It's a bug, plain and simple.  To
> wrap the bug into "a spec" somehow seems wrong to me, especially when
> it would be far better to report the problem as a bug.
> 
> Sure, specs make suit-wearing people happy, but that doesn't mean that
> they're appropriate as a bug reporting method. 8)

Use libata, which does polling and sleeping ;-)

	Jeff



