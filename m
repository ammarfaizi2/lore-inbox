Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbQLDUdy>; Mon, 4 Dec 2000 15:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129734AbQLDUds>; Mon, 4 Dec 2000 15:33:48 -0500
Received: from 62-6-229-244.btconnect.com ([62.6.229.244]:4869 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S129226AbQLDUd3>;
	Mon, 4 Dec 2000 15:33:29 -0500
Date: Mon, 4 Dec 2000 20:05:04 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Alexander Viro <viro@math.psu.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Attempt to hard link across filesystems results in
 un-unmountable filesystem (fwd)
In-Reply-To: <Pine.GSO.4.21.0012041455510.7166-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0012042003350.1458-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Dec 2000, Alexander Viro wrote:
> Tigran, think about the uses from knfsd.

Yes, you are right. I thought I grepped for all usages of vfs_link but
looks like I did not, i.e. when sending the patch I was sure that sys_link
is the only user of vfs_link but now that you pointed it out I clearly see
why my suggestion was wrong.

Thank you,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
