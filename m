Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268338AbRGWTwg>; Mon, 23 Jul 2001 15:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268333AbRGWTw0>; Mon, 23 Jul 2001 15:52:26 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:15120 "HELO holly.csn.ul.ie")
	by vger.kernel.org with SMTP id <S268357AbRGWTwG>;
	Mon, 23 Jul 2001 15:52:06 -0400
Date: Mon, 23 Jul 2001 20:52:04 +0100 (IST)
From: Dave Airlie <airlied@skynet.ie>
X-X-Sender: <airlied@skynet>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Dave Airlie <airlied@skynet.ie>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        <nfs-devel@linux.kernel.org>, <nfs@lists.sourceforge.net>
Subject: Re: [NFS] Solaris 2.6 server Linux 2.2.19 client .. stale handle
In-Reply-To: <shslmlfwkwo.fsf@charged.uio.no>
Message-ID: <Pine.LNX.4.32.0107232051280.22712-100000@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


Cool,
	I noticed another problem on our system also, that explains some
of the times I see it ...

Thanks,
	Dave.

On 23 Jul 2001, Trond Myklebust wrote:

> >>>>> " " == Dave Airlie <airlied@skynet.ie> writes:
>
>      > Hi,
>      > 	I'm running Linux 2.2.19 client NFSv3 from a Solaris 2.6
>      > 	server,
>      > when the server reboots I get stale handles on any mounts from
>      > that server...
>
>      > I though this got fixed ages ago... or do I need to patch
>      > something on the Solaris side?
>
> No. I just need to do a backport of
>
>   http://www.fys.uio.no/~trondmy/src/2.4.7/linux-2.4.7-stale.dif
>
> Cheers,
>   Trond
>

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied@skynet.ie
pam_smb / Linux DecStation / Linux VAX / ILUG person


