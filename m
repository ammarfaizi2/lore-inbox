Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751192AbWJEUM3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbWJEUM3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 16:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbWJEUM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 16:12:29 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:51074 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751192AbWJEUM2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 16:12:28 -0400
Message-ID: <45256728.2060004@garzik.org>
Date: Thu, 05 Oct 2006 16:12:24 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
CC: James Bottomley <James.Bottomley@SteelEye.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-scsi <linux-scsi@vger.kernel.org>
Subject: Re: [GIT PATCH] scsi updates for post 2.6.18
References: <1159995678.3437.80.camel@mulgrave.il.steeleye.com> <Pine.LNX.4.60.0610052104330.6619@poirot.grange> <45255A02.2010308@garzik.org> <Pine.LNX.4.60.0610052129020.6619@poirot.grange>
In-Reply-To: <Pine.LNX.4.60.0610052129020.6619@poirot.grange>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guennadi Liakhovetski wrote:
> Sure, it WOULD be nice, but I don't know how. The "don't know" refers to 
> the case 16MB block size, my tape supports only 16MB - 1 byte (according 
> to st report). Is there a way to test various block sizes with CDs / 
> hard-disks / ZIP / scanners? Would something with sg_dd work? Looks like 
> it must be only sector size. Can I low-level format a disk with 16M 
> sector?:-)
> 
> Another possibility is to limit the block size at 8MB - I can test that.

I would say, increase it to whatever the max is you can test...

	Jeff


