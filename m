Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318516AbSHWJsm>; Fri, 23 Aug 2002 05:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318719AbSHWJsm>; Fri, 23 Aug 2002 05:48:42 -0400
Received: from mx5.sac.fedex.com ([199.81.194.37]:30476 "EHLO
	mx5.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S318516AbSHWJsl>; Fri, 23 Aug 2002 05:48:41 -0400
Date: Fri, 23 Aug 2002 17:51:20 +0800 (SGT)
From: Jeff Chua <jchua@fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: strange problem with initrd
Message-ID: <Pine.LNX.4.44.0208231738420.20492-100000@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 08/23/2002
 05:52:48 PM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 08/23/2002
 05:52:51 PM,
	Serialize complete at 08/23/2002 05:52:51 PM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linux version 2.4.20pre4. But it seems to be happen on all versions as
well.

gcc-3.2, glibc-2.2.5 (compiled with gcc-3.2)


Using loadlin with initrd specifying different ramdisk_size (eg. 23000,
28000, ...)

initrd=ramc1.gz (created by "gzip -9")

Linux will fail to boot failing at ...

RAMDISK: Compressed image found at block 0
invalid compressed format (err=2)<6>Freeing initrd memory: 8162k freed


Does this mean the kernel can't recognized imaged compressed under
gcc-3.2?

Thanks,
Jeff
[ jchua@fedex.com ]

