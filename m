Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129259AbQKUBq3>; Mon, 20 Nov 2000 20:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129379AbQKUBqT>; Mon, 20 Nov 2000 20:46:19 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:16389 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129259AbQKUBqG>; Mon, 20 Nov 2000 20:46:06 -0500
Message-ID: <3A19CBD3.FC897005@timpanogas.org>
Date: Mon, 20 Nov 2000 18:11:47 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Ion Badulescu <ionut@moisil.cs.columbia.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: NFS 2.4.0-11 noisy messages/NFS rpc.lockd returns error
In-Reply-To: <200011210111.eAL1Bdj15941@moisil.dev.hydraweb.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ion Badulescu wrote:
> 
> On Mon, 20 Nov 2000 17:56:20 -0700, Jeff V. Merkey <jmerkey@timpanogas.org> wrote:
> 
> > also, the rpc.lockd program is reporting an error when invoked from the
> > System V init startup scripts:
> >
> > lockd: lockdsvc: invalid argument
> 
> lockd is a kernel thread nowadays, remove it from your nfsd start script
> or simply ignore the error (if you want compatibility with 2.2 kernels
> before 2.2.18).
> 

Thanks.  I saw [lockd] running from ps -ax along with [rpciod] --
performance was also significantly faster.  2.2 compatibility is a
problem, but not a serious one.  I am updating initscripts.rpm.  More
stuff in the kernel is always better.

Jeff

> Ion
> 
> --
>   It is better to keep your mouth shut and be thought a fool,
>             than to open it and remove all doubt.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
