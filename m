Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030264AbWFIQJL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030264AbWFIQJL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 12:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030268AbWFIQJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 12:09:10 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:38542 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030261AbWFIQJJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 12:09:09 -0400
Message-ID: <44899D20.5010500@garzik.org>
Date: Fri, 09 Jun 2006 12:09:04 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Alex Tomas <alex@clusterfs.com>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org, Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>	<4488E1A4.20305@garzik.org>	<20060609083523.GQ5964@schatzie.adilger.int>	<44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org>	<Pine.LNX.4.64.0606090836160.5498@g5.osdl.org>	<448997FA.50109@garzik.org> <m3irnacohp.fsf@bzzz.home.net>	<44899A1C.7000207@garzik.org> <m3ac8mcnye.fsf@bzzz.home.net>
In-Reply-To: <m3ac8mcnye.fsf@bzzz.home.net>
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
>  JG> Think about how this will be deployed in production, long term.
> 
>  JG> If extents are not made default at some point, then no one will use
>  JG> the feature, and it should not be merged.
> 
> sorry, I disagree. for example, NUMA isn't default and shouldn't be.
> but we have it in the tree and any one may choose to use it. the same
> with extents. let's have it in. but let's make clear it's experimental,
> it makes sense for large files only, it isn't backward compatible and
> so on.

NUMA _is_ on by default, in newer hardware kernels :)  K8 is NUMA by 
default, remember.

But anyway...  the "it's experimental" argument is _completely_ 
irrelevant.  You have to think about the day when it is not, and how 
that will get deployed, and what are the potential problems that will 
arise from deployment.

	Jeff



