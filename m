Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264981AbUAGSfN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 13:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265515AbUAGSfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 13:35:13 -0500
Received: from mysnip.de.gw.net-build.de ([194.25.82.254]:18569 "EHLO
	mail.myphorum.de") by vger.kernel.org with ESMTP id S264981AbUAGSfH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 13:35:07 -0500
X-Originating-IP: [unknown]
From: "Thomas Seifert" <thomas-lists@myphorum.com>
To: "Mike Fedyk" <mfedyk@matchmail.com>, "Jirka Kosina" <jikos@jikos.cz>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: XFS over 7.7TB LVM partition through NFS
Date: Wed, 07 Jan 2004 18:35:05 +0000
Message-ID: <20040107.8Z4.43021900@db.myphorum.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
X-Mailer: AngleMail for phpGroupWare (http://www.phpgroupware.org) v 0.9.99.008
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fsck? shouldn't it read
xfs_repair
???


thomas

Mike Fedyk (mfedyk@matchmail.com) schrieb:
>
> On Wed, Jan 07, 2004 at 07:09:00PM +0100, Jirka Kosina wrote:
> > On Wed, 7 Jan 2004, Jirka Kosina wrote:
> >
> > > I am experiencing problems with LVM2 XFS partition in 2.6.0 being accessed
> > > over NFS. After exporting the filesystem clients start writing files to
> > > this partition over NFS, and after a short while we get this call trace,
> > > repeating indefinitely on the screen and the machine stops responding
> > > (keyboard, network):
> >
> > I am sorry, I have mis-pasted the log, it was not complete - there are two
> > extra lines before the Call Trace ... these two:
> >
> > Jan  8 01:38:35 storage2 kernel: 0x0: 94 38 73 54 cc 8c c9 be 0c 3e 6b 30
> > 4c 9f 54 c5
> > Jan  8 01:38:35 storage2 kernel: Filesystem "dm-0": XFS internal error
> > xfs_alloc_read_agf at line 2208 of file fs/xfs/xfs_alloc.c.  Caller 0xc01fab06
>
> Try a fsck on your xfs partitions.
>
>
>

