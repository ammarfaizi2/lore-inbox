Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282967AbRLDJX0>; Tue, 4 Dec 2001 04:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282961AbRLDJXT>; Tue, 4 Dec 2001 04:23:19 -0500
Received: from nick.dcs.qmul.ac.uk ([138.37.88.61]:42155 "EHLO
	nick.dcs.qmul.ac.uk") by vger.kernel.org with ESMTP
	id <S282960AbRLDJWw>; Tue, 4 Dec 2001 04:22:52 -0500
Date: Tue, 4 Dec 2001 09:22:51 +0000 (GMT)
From: Matt Bernstein <matt@theBachChoir.org.uk>
To: <nbecker@fred.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: nfs: task can't get a request slot
In-Reply-To: <x88u1v8jt40.fsf@rpppc1.hns.com>
Message-ID: <Pine.LNX.4.33.0112040921170.2274-100000@nick.dcs.qmul.ac.uk>
X-URL: http://www.theBachChoir.org.uk/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Have a look at adglinux1 and see if its NFS server is still alive.
Your hung processes should "unhang" when rpppc1 can see the server again.

On Dec 3 nbecker@fred.net wrote:

[snip]
>What does this mean?
>
>Dec  3 08:53:54 rpppc1 kernel: nfs: server adglinux1 not responding, still trying
>Dec  3 08:53:54 rpppc1 kernel: nfs: server adglinux1 not responding, still trying
>Dec  3 08:55:09 rpppc1 rpc.mountd: authenticated mount request from 139.85.108.152:890 for /disk1/nbecker (/disk1)
>Dec  3 08:55:43 rpppc1 kernel: nfs: task 3408 can't get a request slot
>Dec  3 08:55:43 rpppc1 kernel: nfs: task 3409 can't get a request slot
[snip]

