Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262364AbTCRMDB>; Tue, 18 Mar 2003 07:03:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262367AbTCRMDB>; Tue, 18 Mar 2003 07:03:01 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:27150 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S262364AbTCRMDA>; Tue, 18 Mar 2003 07:03:00 -0500
Message-ID: <3E770E02.8020505@aitel.hist.no>
Date: Tue, 18 Mar 2003 13:16:02 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix waitqueue leak in devfs_d_revalidate_wait
References: <20030318105625.B4424@lst.de> <20030318032146.04f32a6b.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
[...]
> It seems to work OK now, but there are a few small incompatibilities with the
> current devfs.  People need to make adjustments to their initscripts, or to
> untar a tarball-of-device-nodes into smalldevfs at boot time.

I assume smalldevfs is what you get when you configure devfs in 2.5.64-mm8?
It works fine for me, on smp with debian testing. I changed nothing
at all, and noticed that devfsd didn't run.  But it don't seem necessary,
it seems to work even without those compatibility symlinks.

> Adam is disinclined to address these administrative incompatibilites in his
> user-space tools.  smalldevfs is presently at risk of getting dropped out.

Please continue, it works and I understand the code is an improvement.
I'll begin testing on my work pc too.

Helge Hafting

