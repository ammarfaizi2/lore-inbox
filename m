Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161216AbWHJMds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161216AbWHJMds (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 08:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161227AbWHJMds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 08:33:48 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:48862 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1161216AbWHJMdr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 08:33:47 -0400
Message-ID: <44DB27A3.1040606@garzik.org>
Date: Thu, 10 Aug 2006 08:33:39 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: Andrew Morton <akpm@osdl.org>, cmm@us.ibm.com,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/9] sector_t format string
References: <1155172843.3161.81.camel@localhost.localdomain> <20060809234019.c8a730e3.akpm@osdl.org> <Pine.LNX.4.64.0608101302270.6762@scrub.home> <44DB203A.6050901@garzik.org> <Pine.LNX.4.64.0608101409350.6762@scrub.home> <44DB25C1.1020807@garzik.org> <Pine.LNX.4.64.0608101429510.6762@scrub.home>
In-Reply-To: <Pine.LNX.4.64.0608101429510.6762@scrub.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> Hi,
> 
> On Thu, 10 Aug 2006, Jeff Garzik wrote:
> 
>> Roman Zippel wrote:
>>> Yes, it does, but I don't think it's that difficult - basically returning
>>> -EIO, it should be part of the basic error handling. Afterwards you don't
>>> have to waste cpu/memory on unused data anymore.
>> Or you could just not bother, and leave everything as u64.
> 
> Why?

To eliminate needless complexity and keep things simple and obvious?

	Jeff



