Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314546AbSHZIbC>; Mon, 26 Aug 2002 04:31:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315720AbSHZIbC>; Mon, 26 Aug 2002 04:31:02 -0400
Received: from mx7.sac.fedex.com ([199.81.194.38]:19475 "EHLO
	mx7.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S314546AbSHZIbB>; Mon, 26 Aug 2002 04:31:01 -0400
Date: Mon, 26 Aug 2002 16:34:36 +0800 (SGT)
From: Jeff Chua <jchua@fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [BUG] initrd >24MB corruption
Message-ID: <Pine.LNX.4.44.0208261621190.2610-100000@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 08/26/2002
 04:35:08 PM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 08/26/2002
 04:35:11 PM,
	Serialize complete at 08/26/2002 04:35:11 PM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I posted a similar message last week. No response, but that was on
Gcc3.2, but when I tried out on gcc2.95.3, it failed too.

Symptons:
	create 28MB ramdisk, fill up to 18MB, system boots ok.

	create 28MB ramdisk, fill up to 24MB, system can't boot, fail at

	RAMDISK: Compressed image found at block 0 ... then stuck!


What's the next step to debug this?


Thanks,
Jeff
[ jchua@fedex.com ]

