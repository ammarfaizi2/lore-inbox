Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313419AbSDYUtf>; Thu, 25 Apr 2002 16:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313421AbSDYUte>; Thu, 25 Apr 2002 16:49:34 -0400
Received: from heffalump.fnal.gov ([131.225.9.20]:6653 "EHLO fnal.gov")
	by vger.kernel.org with ESMTP id <S313419AbSDYUtd>;
	Thu, 25 Apr 2002 16:49:33 -0400
Date: Thu, 25 Apr 2002 15:49:32 -0500
From: Dan Yocum <yocum@fnal.gov>
Subject: Poor NFS client performance on 2.4.18?
To: linux kernel <linux-kernel@vger.kernel.org>
Message-id: <3CC86BDC.C8784EA2@fnal.gov>
MIME-version: 1.0
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-13SGI_XFS_1.0.2 i686)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond, et al.

I'm getting poor NFS performance (~250KBps read and write) on 2.4.18 and am
wondering if I'm the only one.  There is no performance drop under other OSs
or other kernel versions, so I don't think it's the server.

Here's the the details:

2.4.18 patched with:
	NFS client patches (linux-2.4.18-NFS_ALL.dif) 
	xfs-1.1-PR1-2.4.18-all.patch
	Ingo's Foster IRQ patch (these are dual Xeons)

If you need any more details, let me know.

Thanks,
Dan


-- 
Dan Yocum
Sloan Digital Sky Survey, Fermilab  630.840.6509
yocum@fnal.gov, http://www.sdss.org
SDSS.  Mapping the Universe.
