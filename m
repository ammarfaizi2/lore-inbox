Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965279AbWFIOYA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965279AbWFIOYA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 10:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965271AbWFIOYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 10:24:00 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:29065 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965270AbWFIOX7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 10:23:59 -0400
Message-ID: <44898476.80401@garzik.org>
Date: Fri, 09 Jun 2006 10:23:50 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Alex Tomas <alex@clusterfs.com>
CC: Christoph Hellwig <hch@infradead.org>, Mingming Cao <cmm@us.ibm.com>,
       linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>	<20060609091327.GA3679@infradead.org> <m364jafu3h.fsf@bzzz.home.net>
In-Reply-To: <m364jafu3h.fsf@bzzz.home.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Tomas wrote:
>>>>>> Christoph Hellwig (CH) writes:
> 
>  CH> If you guys want big storage on linux please help improving the filesystems
>  CH> design for that, e.g. jfs or xfs instead of showhorning it onto ext3 thus
>  CH> both making ext3 less reliable for us desktop/small server users and not get
>  CH> the full thing for the big storage people either.
> 
> proposed patches don't touch existing code paths.
> extents may be enabled/disabled on per-file basis.

And thus, inodes are progressively incompatible with older kernels. 
Boot into an older kernel, and you can now only read half your 
filesystem (if it even allows mount at all).

	Jeff



