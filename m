Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263605AbRFSFAt>; Tue, 19 Jun 2001 01:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263607AbRFSFAj>; Tue, 19 Jun 2001 01:00:39 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:12554
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S263605AbRFSFA2>; Tue, 19 Jun 2001 01:00:28 -0400
Date: Tue, 19 Jun 2001 00:59:37 -0400
From: Chris Mason <mason@suse.com>
To: Shawn Starr <spstarr@sh0n.net>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.6-pre3 breaks ReiserFS mount on boot
Message-ID: <1480690000.992926777@tiny>
In-Reply-To: <Pine.LNX.4.30.0106182355500.118-100000@coredump.sh0n.net>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Monday, June 18, 2001 11:57:16 PM -0400 Shawn Starr <spstarr@sh0n.net>
wrote:

> 
> read_super_block: can't find a reiserfs filesystem on dev 03:42
> read_old_super_block: try to find super block in old location
> read_old_super_block: can't find a reiserfs filesystem on dev 03:42
> Kernel Panic: VFS: Unable to mount root fs on 03:42
> 
> my super block broke somewhere?

Well, this one is usually due to massive corruption or a configuration 
error. Are the correct drives and controllers found during boot?

-chris

