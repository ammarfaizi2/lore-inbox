Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030299AbWEZEGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030299AbWEZEGU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 00:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030318AbWEZEGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 00:06:19 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:8147 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S1030299AbWEZEGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 00:06:19 -0400
To: cmm@us.ibm.com
Cc: adilger@clusterfs.com, jitendra@linsyssoft.com,
       ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [UPDATE][0/24]extend file size and filesystem size
Message-Id: <20060526130555sho@rifu.tnes.nec.co.jp>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: sho@tnes.nec.co.jp
Date: Fri, 26 May 2006 13:05:55 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mingming,

On May 26, 2006, Mingming wrote:
> As we have discussed before, it's saner to define ext3 fs blocks type
> and group block type and then fix the kernel ext3 block variable type
> bugs....So above patches from me are going to be replaced by a new
> set of ext3 filesystem blocks patches, I have sent out a RFC to the
> ext2-devel list in the last few weeks:

I agree.  But the aim of this fix is to keep as much compatibility as
possible by making only >2TB file incompatible(RO).  So I didn't add
typedef for ext3 block type.

Now I'm working on changing the type of variables related to block,
including ext3_fileblk_t.  I'll send the update patches later.


Cheer, sho


