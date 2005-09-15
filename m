Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965276AbVIOWPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965276AbVIOWPS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 18:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965287AbVIOWPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 18:15:18 -0400
Received: from blackstar.xs4all.nl ([80.126.234.51]:7524 "EHLO blackstar.nl")
	by vger.kernel.org with ESMTP id S965276AbVIOWPR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 18:15:17 -0400
Subject: Re: 2.6.14-rc1 - kernel BUG at fs/ntfs/aops.c:403
From: Bas Vermeulen <bvermeul@blackstar.nl>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.60.0509152219260.21782@hermes-1.csi.cam.ac.uk>
References: <1126769362.5358.3.camel@laptop.blackstar.nl>
	 <Pine.LNX.4.60.0509150954290.29921@hermes-1.csi.cam.ac.uk>
	 <1126812296.4776.2.camel@laptop.blackstar.nl>
	 <Pine.LNX.4.60.0509152219260.21782@hermes-1.csi.cam.ac.uk>
Content-Type: text/plain
Date: Fri, 16 Sep 2005 00:14:03 +0200
Message-Id: <1126822443.4776.3.camel@laptop.blackstar.nl>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-14.WB1) 
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: Please contact the postmaster@blackstar.nl for more information
X-MailScanner: No virus found
X-MailScanner-From: bvermeul@blackstar.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-09-15 at 22:21 +0100, Anton Altaparmakov wrote:
> On Thu, 15 Sep 2005, Bas Vermeulen wrote:
> > Sep 15 21:13:43 laptop kernel: [4295071.339000] NTFS volume version 3.1.
> > Sep 15 21:13:43 laptop kernel: [4295071.339000] NTFS-fs error (device
> > sda2): load_system_files(): Volume is dirty.  Mounting read-only.  Run
> > chkdsk and mount in Windows.
> > Sep 15 21:13:43 laptop kernel: [4295071.439000] NTFS-fs error (device
> > sda2): ntfs_readpage(): Eeek!  i_ino = 0x5, type = 0xa0, name_len = 0x4.
> 
> Great, thanks!  I suspected this might be the case but I didn't think 
> that was possible.  )-:
> 
> Could you confirm for me that this ntfs volume is compressed?  (I.e. the 
> compression bit is enabled on the root directory.)

Yes, it is compressed.

Regards,

-- 
Bas Vermeulen <bvermeul@blackstar.nl>

