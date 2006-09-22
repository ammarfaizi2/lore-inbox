Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbWIVKqD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbWIVKqD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 06:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932112AbWIVKqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 06:46:03 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:13798 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932108AbWIVKqB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 06:46:01 -0400
Date: Fri, 22 Sep 2006 12:42:29 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: David Woodhouse <dwmw2@infradead.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       rdunlap@xenotime.net
Subject: Re: 2.6.19 -mm merge plans
In-Reply-To: <1158919801.24527.668.camel@pmac.infradead.org>
Message-ID: <Pine.LNX.4.61.0609221242070.791@yvahk01.tjqt.qr>
References: <20060920135438.d7dd362b.akpm@osdl.org> 
 <1158917046.24527.662.camel@pmac.infradead.org> <1158919801.24527.668.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > mtd-maps-ixp4xx-partition-parsing.patch
>> > fix-the-unlock-addr-lookup-bug-in-mtd-jedec-probe.patch
>> > mtd-printk-format-warning.patch
>> > fs-jffs2-jffs2_fs_ih-removal-of-old-code.patch
>> > drivers-mtd-nand-au1550ndc-removal-of-old-code.patch
>> > 
>> >  MTD queue -> dwmw2
>> 
>> Merged, with the exception of the unlock addr one which I'm still not
>> sure about -- about to investigate harder.
>
>I just reverted Randy's printk format 'fix', since rq->flags _is_ an
>unsigned long, so changing from %ld to %d actually _introduces_ a
>warning.

If it is an unsigned long, it should neither be %ld nor %d, but %lu.



Jan Engelhardt
-- 
