Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131560AbRCSTXA>; Mon, 19 Mar 2001 14:23:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131561AbRCSTWv>; Mon, 19 Mar 2001 14:22:51 -0500
Received: from dfw-smtpout2.email.verio.net ([129.250.36.42]:53894 "EHLO
	dfw-smtpout2.email.verio.net") by vger.kernel.org with ESMTP
	id <S131560AbRCSTWh>; Mon, 19 Mar 2001 14:22:37 -0500
Message-ID: <3AB65C51.3DF150E5@bigfoot.com>
Date: Mon, 19 Mar 2001 11:21:53 -0800
From: Tim Moore <timothymoore@bigfoot.com>
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.19pre17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: UDMA 100 / PIIX4 question
In-Reply-To: <20010318165246Z131240-406+1417@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

quintaq@yahoo.co.uk wrote:
> I have an IBM DTLA 307030 (ATA 100 / UDMA 5) on an 815e board (Asus CUSL2), which has a PIIX4 controller.
> ...
> My problem is that (according to hdparm -t), I never get a better transfer rate than approximately 15.8 Mb/sec.  I achieve this when DMA is enabled, - without it I fall back to about 5 Mb /sec.  No amount of fiddling with other hdparm settings makes any difference.
> ...

15MB/s for hdparm is about right.

"...four IDE devices can be supported in Bus Master mode.
 PIIX4 contains support for "Ultra DMA/33" synchronous DMA
 compatible devices."

http://developer.intel.com/design/intarch/techinfo/440BX/PIIX4_intro.htm

--
