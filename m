Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262324AbTCRLK6>; Tue, 18 Mar 2003 06:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262329AbTCRLK5>; Tue, 18 Mar 2003 06:10:57 -0500
Received: from packet.digeo.com ([12.110.80.53]:17806 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262324AbTCRLK5>;
	Tue, 18 Mar 2003 06:10:57 -0500
Date: Tue, 18 Mar 2003 03:21:46 -0800
From: Andrew Morton <akpm@digeo.com>
To: Christoph Hellwig <hch@lst.de>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix waitqueue leak in devfs_d_revalidate_wait
Message-Id: <20030318032146.04f32a6b.akpm@digeo.com>
In-Reply-To: <20030318105625.B4424@lst.de>
References: <20030318105625.B4424@lst.de>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Mar 2003 11:21:36.0721 (UTC) FILETIME=[89E8A410:01C2ED40]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@lst.de> wrote:
>
> I still hope Adam's smalldevfs will get merged anyway..

Well me too, but smalldevfs is a bit stalled at present.

It seems to work OK now, but there are a few small incompatibilities with the
current devfs.  People need to make adjustments to their initscripts, or to
untar a tarball-of-device-nodes into smalldevfs at boot time.

Like all other kernel developers I do not use devfs and am not really able to
evaluate how serious these problems will be for people.

Adam is disinclined to address these administrative incompatibilites in his
user-space tools.  smalldevfs is presently at risk of getting dropped out.



