Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262193AbUKQDXo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262193AbUKQDXo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 22:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262189AbUKQDWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 22:22:19 -0500
Received: from fw.osdl.org ([65.172.181.6]:16063 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262185AbUKQDVM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 22:21:12 -0500
Date: Tue, 16 Nov 2004 19:20:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: aia21@cam.ac.uk, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: Re: [2.6-BK-URL] NTFS 2.1.22 - Bug and race fixes and improved
 error handling.
Message-Id: <20041116192049.0ca4efa3.akpm@osdl.org>
In-Reply-To: <1100644656.17573.0.camel@krustophenia.net>
References: <E1CRsk5-0006JQ-KD@imp.csi.cam.ac.uk>
	<1100644656.17573.0.camel@krustophenia.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> wrote:
>
> On Wed, 2004-11-10 at 13:42 +0000, Anton Altaparmakov wrote:
> > Hi Linus, Hi Andrew, please do a
> > 
> > 	bk pull bk://linux-ntfs.bkbits.net/ntfs-2.6
> > 
> 
> New warning with 2.6.10-rc2-mm1:
> 
>   CC [M]  fs/ntfs/super.o
> fs/ntfs/super.c: In function `__get_nr_free_mft_records':
> fs/ntfs/super.c:2105: warning: initialization from incompatible pointer type

That's my whacky hack to detect kunmap_atomic() bugs.  I'll fix things up,
thanks.
