Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030182AbWFIOgF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030182AbWFIOgF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 10:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030185AbWFIOgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 10:36:04 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:3978 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030181AbWFIOgC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 10:36:02 -0400
Message-ID: <4489874C.1020108@garzik.org>
Date: Fri, 09 Jun 2006 10:35:56 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Alex Tomas <alex@clusterfs.com>
CC: Christoph Hellwig <hch@infradead.org>, Mingming Cao <cmm@us.ibm.com>,
       linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>	<20060609091327.GA3679@infradead.org> <m364jafu3h.fsf@bzzz.home.net>	<44898476.80401@garzik.org> <m33beee6tc.fsf@bzzz.home.net>
In-Reply-To: <m33beee6tc.fsf@bzzz.home.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Tomas wrote:
>>>>>> Jeff Garzik (JG) writes:
> 
>  JG> And thus, inodes are progressively incompatible with older
>  JG> kernels. Boot into an older kernel, and you can now only read half
>  JG> your filesystem (if it even allows mount at all).
> 
> nope, you aren't allowed to mount fs with extents-enabled files
> by ext3 which has no the feature compiled in. the same will
> happen if you call it ext4.

This is my point...  why increase user confusion by calling it ext3, then?

Extent magnify the "what ext3 filesystem am I talking to, today?" problem.

	Jeff



