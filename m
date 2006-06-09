Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030311AbWFIRMW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030311AbWFIRMW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 13:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030308AbWFIRMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 13:12:22 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:35473 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030238AbWFIRMU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 13:12:20 -0400
Message-ID: <4489ABF0.2010703@garzik.org>
Date: Fri, 09 Jun 2006 13:12:16 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Alex Tomas <alex@clusterfs.com>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org, Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>	<4488E1A4.20305@garzik.org>	<20060609083523.GQ5964@schatzie.adilger.int>	<44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org>	<Pine.LNX.4.64.0606090836160.5498@g5.osdl.org>	<m33beecntr.fsf@bzzz.home.net>	<Pine.LNX.4.64.0606090913390.5498@g5.osdl.org>	<m3k67qb7hr.fsf@bzzz.home.net> <4489A7ED.8070007@garzik.org> <m3r71y9rt8.fsf@bzzz.home.net>
In-Reply-To: <m3r71y9rt8.fsf@bzzz.home.net>
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
>  JG> That is what the entirety of Linux development is -- step-by-step.
> 
>  JG> It is OBVIOUS that it would take five minutes to start ext4.
> 
> right. it's not a problem to *start*. it's a problem it maintain.
> day by day fs/ext3 and fs/ext4 will get more and more diffs.
> at some point it will be a headache to apply patches from ext3
> to ext4 and back. I known this very well ....

As Linus has stated, we have empirical evidence that splitting 
filesystems works, for both stability and development speed.

The number of patches to ext[23] will trickle off over time.  As the 
obvious example, ext4 would receive the extent and 48bit patches rather 
than ext3 :)

	Jeff



