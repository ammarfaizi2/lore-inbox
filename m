Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278502AbRJPC1j>; Mon, 15 Oct 2001 22:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278504AbRJPC13>; Mon, 15 Oct 2001 22:27:29 -0400
Received: from patan.Sun.COM ([192.18.98.43]:21657 "EHLO patan.sun.com")
	by vger.kernel.org with ESMTP id <S278502AbRJPC1P>;
	Mon, 15 Oct 2001 22:27:15 -0400
Message-ID: <3BCB9A65.7A2BDABF@sun.com>
Date: Mon, 15 Oct 2001 19:24:37 -0700
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alan@redhat.com,
        torvalds@transmeta.com
Subject: Re: [PATCH] fix NFS root in 2.4.12
In-Reply-To: <Pine.GSO.4.21.0110152207520.11608-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:

> Had you actually tried to compile that? do_kern_mount() is defined as
> 
> struct vfsmount *do_kern_mount(char *type, int flags, char *name, void *data)
> 
> Where did you find 5th argument?

DOH!  In the XFS patch, apparently :)  This should have been sent to the
XFS people, if at all.

My bad.

Tim
-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
