Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264379AbTGBPDq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 11:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265024AbTGBPDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 11:03:46 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:9286 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264379AbTGBPDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 11:03:45 -0400
Date: Wed, 2 Jul 2003 08:18:42 -0700
From: Andrew Morton <akpm@digeo.com>
To: maneesh@in.ibm.com
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.73-mm3
Message-Id: <20030702081842.45f4056f.akpm@digeo.com>
In-Reply-To: <20030702105458.GH1267@in.ibm.com>
References: <20030701203830.19ba9328.akpm@digeo.com>
	<20030702105458.GH1267@in.ibm.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Jul 2003 15:18:10.0288 (UTC) FILETIME=[25B89700:01C340AD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maneesh Soni <maneesh@in.ibm.com> wrote:
>
> On Wed, Jul 02, 2003 at 03:39:54AM +0000, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.73/2.5.73-mm3/
> > 
> > . The ext2 "free inodes corrupted" problem which Martin saw should be
> >   fixed.
> > 
> > . The ext3 assertion failure which Maneesh hit should be fixed (I can't
> >   reproduce this, please retest?)
> > 
> 
> It is fixed. Ran multiple iterations without any ext3 assertion failure. 

Sweet, thanks.

And thanks also for the ext3-debug trace - that found the bug in sixty
seconds of peering.
