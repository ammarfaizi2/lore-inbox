Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030228AbWFIPrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030228AbWFIPrL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 11:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030227AbWFIPrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 11:47:11 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:59788 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030222AbWFIPrJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 11:47:09 -0400
Message-ID: <448997FA.50109@garzik.org>
Date: Fri, 09 Jun 2006 11:47:06 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org, Andreas Dilger <adilger@clusterfs.com>,
       cmm@us.ibm.com, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC 0/13] extents and 48bit ext3
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com> <4488E1A4.20305@garzik.org> <20060609083523.GQ5964@schatzie.adilger.int> <44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org> <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Fri, 9 Jun 2006, Jeff Garzik wrote:
>> Overall, I'm surprised that ext3 developers don't see any of the problems
>> related to progressive, stealth filesystem upgrades.
> 
> Hey, they're used to it - they've been doing it for a long time.

Agreed, but my argument is that extents are a Big Deal.

think about The Experience:  Suddenly users that could use 2.4.x and 
2.6.x are locked into 2.6.18+, by the simple and common act of writing 
to a file.

No bells and whistles go off...

	Jeff


