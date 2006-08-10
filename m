Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161887AbWHJNPG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161887AbWHJNPG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 09:15:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161885AbWHJNPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 09:15:06 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:16608 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1161883AbWHJNPE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 09:15:04 -0400
Message-ID: <44DB3151.8050904@garzik.org>
Date: Thu, 10 Aug 2006 09:14:57 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: Andrew Morton <akpm@osdl.org>, cmm@us.ibm.com,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/9] sector_t format string
References: <1155172843.3161.81.camel@localhost.localdomain> <20060809234019.c8a730e3.akpm@osdl.org> <Pine.LNX.4.64.0608101302270.6762@scrub.home> <44DB203A.6050901@garzik.org> <Pine.LNX.4.64.0608101409350.6762@scrub.home> <44DB25C1.1020807@garzik.org> <Pine.LNX.4.64.0608101429510.6762@scrub.home> <44DB27A3.1040606@garzik.org> <Pine.LNX.4.64.0608101459260.6761@scrub.home>
In-Reply-To: <Pine.LNX.4.64.0608101459260.6761@scrub.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> On Thu, 10 Aug 2006, Jeff Garzik wrote:
>>>> Or you could just not bother, and leave everything as u64.
>>> Why?
>> To eliminate needless complexity and keep things simple and obvious?
> 
> Considering the amount of complexity we add for the high end, why is it 
> suddenly a bad thing to add even a _little_ complexity for the other end?

This is ext4 not ext3 we're talking about.  The next gen Linux 
filesystem should be tuned for modern machines -- 64bit, moving forward 
-- while still working just fine on 32bit.

	Jeff


