Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030397AbWFIS44@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030397AbWFIS44 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 14:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030396AbWFIS44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 14:56:56 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:15510 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030388AbWFIS4z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 14:56:55 -0400
Message-ID: <4489C43C.6000906@garzik.org>
Date: Fri, 09 Jun 2006 14:55:56 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Michael Poole <mdpoole@troilus.org>
CC: Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       cmm@us.ibm.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 0/13] extents and 48bit ext3
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>	<20060609091327.GA3679@infradead.org>	<20060609030759.48cd17a0.akpm@osdl.org> <44899653.1020007@garzik.org> <87irnab33v.fsf@graviton.dyn.troilus.org>
In-Reply-To: <87irnab33v.fsf@graviton.dyn.troilus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Poole wrote:
> Jeff Garzik writes:
> 
>> Andrew Morton wrote:
>>> Ted&co have been pretty good at avoiding compatibility problems.
>> Well, extents and 48bit make that track record demonstrably worse.
>>
>> Users are now forced to remember that, if they write to their
>> filesystem after using either $mmver or $korgver kernels, they are
>> locked out of using older kernels.
> 
> Users are also forced to remember that, if they use certain new
> distros or programs, they are locked out of using older kernels.  They
> are forced to remember that if they have certain newer hardware, they
> are locked out of using older kernels.  They are forced to remember
> that if they use ext3 (or XFS or JFS) _at all_ they are locked out of
> using older kernels.  Why single out this particular aspect of limited
> forward compatibility to harp on so much?

Because it's called backwards compat, when it isn't?
Because it is very difficult to find out which set of kernels you are 
locked out of?
Because the filesystem upgrade is stealthy, occurring as it does on the 
first data write?

	Jeff



