Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266265AbUAGSJG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 13:09:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266266AbUAGSJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 13:09:06 -0500
Received: from twin.jikos.cz ([213.151.79.26]:21400 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S266265AbUAGSJB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 13:09:01 -0500
Date: Wed, 7 Jan 2004 19:09:00 +0100 (CET)
From: Jirka Kosina <jikos@jikos.cz>
To: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: XFS over 7.7TB LVM partition through NFS
In-Reply-To: <Pine.LNX.4.58.0401071824120.31032@twin.jikos.cz>
Message-ID: <Pine.LNX.4.58.0401071907460.31032@twin.jikos.cz>
References: <Pine.LNX.4.58.0401071824120.31032@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jan 2004, Jirka Kosina wrote:

> I am experiencing problems with LVM2 XFS partition in 2.6.0 being accessed 
> over NFS. After exporting the filesystem clients start writing files to 
> this partition over NFS, and after a short while we get this call trace, 
> repeating indefinitely on the screen and the machine stops responding 
> (keyboard, network):

I am sorry, I have mis-pasted the log, it was not complete - there are two 
extra lines before the Call Trace ... these two:

Jan  8 01:38:35 storage2 kernel: 0x0: 94 38 73 54 cc 8c c9 be 0c 3e 6b 30 
4c 9f 54 c5
Jan  8 01:38:35 storage2 kernel: Filesystem "dm-0": XFS internal error 
xfs_alloc_read_agf at line 2208 of file fs/xfs/xfs_alloc.c.  Caller 0xc01fab06

Sorry for the inconvience.

-- 
JiKos.
