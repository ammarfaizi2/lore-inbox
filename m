Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030269AbWFIQLH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030269AbWFIQLH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 12:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030273AbWFIQLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 12:11:06 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:49806 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030269AbWFIQLF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 12:11:05 -0400
Message-ID: <44899D93.5030008@garzik.org>
Date: Fri, 09 Jun 2006 12:10:59 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Alex Tomas <alex@clusterfs.com>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org, Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>	<4488E1A4.20305@garzik.org>	<20060609083523.GQ5964@schatzie.adilger.int>	<44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org>	<Pine.LNX.4.64.0606090836160.5498@g5.osdl.org> <m33beecntr.fsf@bzzz.home.net>
In-Reply-To: <m33beecntr.fsf@bzzz.home.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Tomas wrote:
>>>>>> Linus Torvalds (LT) writes:
> 
> 
>  LT> Quite frankly, at this point, there's no way in hell I believe we can do 
>  LT> major surgery on ext3. It's the main filesystem for a lot of users, and 
>  LT> it's just not worth the instability worries unless it's something very 
>  LT> obviously transparent.
> 
> I believe it's as stable as before until you mount with extents
> mount option.

If it will remain a mount option, if it is never made the default 
(either in kernel or distro level), then only 1% of users will ever use 
the feature.  And we shouldn't merge a 1% use feature into the _main_ 
filesystem for Linux.

	Jeff



