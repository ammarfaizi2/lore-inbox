Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030367AbWILX0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030367AbWILX0A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 19:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030368AbWILX0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 19:26:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53215 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030367AbWILXZ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 19:25:59 -0400
Date: Tue, 12 Sep 2006 16:25:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc6-mm2
Message-Id: <20060912162555.d71af631.akpm@osdl.org>
In-Reply-To: <6bffcb0e0609120842s6a38b326u4e1fff2e562a6832@mail.gmail.com>
References: <20060912000618.a2e2afc0.akpm@osdl.org>
	<6bffcb0e0609120554j5e69e2sd2c8ebb914c4c9f5@mail.gmail.com>
	<6bffcb0e0609120842s6a38b326u4e1fff2e562a6832@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Sep 2006 17:42:10 +0200
"Michal Piotrowski" <michal.k.k.piotrowski@gmail.com> wrote:

> On 12/09/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> > On 12/09/06, Andrew Morton <akpm@osdl.org> wrote:
> > >
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc6/2.6.18-rc6-mm2/
> > >
> >
> > I get this while umounting jfs (umount segfaulted).
> 
> s/jfs/xfs

Do you mean that both JFS and XFS exhibit this bug, or only XFS?

> /home/michal/bin/test_mount_fs.sh: line 22:  2354 Segmentation fault
> sudo umount /mnt/fs-farm/xfs/
> 

