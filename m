Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261818AbVAGAKD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261818AbVAGAKD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 19:10:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262072AbVAGAJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 19:09:55 -0500
Received: from holomorphy.com ([207.189.100.168]:51905 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261818AbVAGAG3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 19:06:29 -0500
Date: Thu, 6 Jan 2005 16:06:02 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Anton Blanchard <anton@samba.org>
Cc: Andi Kleen <ak@muc.de>, Steve Longerbeam <stevel@mvista.com>,
       Hugh Dickins <hugh@veritas.com>, Ray Bryant <raybry@sgi.com>,
       Christoph Lameter <clameter@sgi.com>,
       Hirokazu Takahashi <taka@valinux.co.jp>,
       Marcello Tosatti <marcelo.tosatti@cyclades.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, andrew morton <akpm@osdl.org>
Subject: Re: page migration patchset
Message-ID: <20050107000602.GF9636@holomorphy.com>
References: <Pine.LNX.4.44.0501052008160.8705-100000@localhost.localdomain> <41DC7EAD.8010407@mvista.com> <20050106144307.GB59451@muc.de> <20050106223046.GB9636@holomorphy.com> <20050106235300.GC14239@krispykreme.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050106235300.GC14239@krispykreme.ozlabs.ibm.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> The second is zero bugfixing or cross-architecture testing activity
>> apart from my own. This and the first in conjunction cast serious
>> doubt upon and increase the need for heavy critical examination of
>> so-called ``consolidation'' patches.

On Fri, Jan 07, 2005 at 10:53:00AM +1100, Anton Blanchard wrote:
> OK lets get moving on the bug fixing. I know of one outstanding hugetlb
> bug which is the one you have been working on.
> Can we have a complete bug report on it so the rest of us can try to assist?

The one-sentence summary is that a triplefault causing machine reset
occurs while hugetlb is used during a long-running regression test for
the Oracle database on both EM64T and x86-64. Thus far attempts to
produce isolated testcases have not been successful. The test involves
duplicating a database across two database instances.

My current work on this consists largely of attempting to get access to
debugging equipment and/or simulators to carry out post-mortem analysis.
I've recently been informed that some of this will be provided to me.


-- wli
