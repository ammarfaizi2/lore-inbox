Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129208AbQKUBmU>; Mon, 20 Nov 2000 20:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129379AbQKUBl7>; Mon, 20 Nov 2000 20:41:59 -0500
Received: from vp175103.reshsg.uci.edu ([128.195.175.103]:36621 "EHLO
	moisil.dev.hydraweb.com") by vger.kernel.org with ESMTP
	id <S129208AbQKUBlw>; Mon, 20 Nov 2000 20:41:52 -0500
Date: Mon, 20 Nov 2000 17:11:39 -0800
Message-Id: <200011210111.eAL1Bdj15941@moisil.dev.hydraweb.com>
From: Ion Badulescu <ionut@moisil.cs.columbia.edu>
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS 2.4.0-11 noisy messages/NFS rpc.lockd returns error
In-Reply-To: <3A19C834.48757E1F@timpanogas.org>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.2.18pre21 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2000 17:56:20 -0700, Jeff V. Merkey <jmerkey@timpanogas.org> wrote:

> also, the rpc.lockd program is reporting an error when invoked from the
> System V init startup scripts:
> 
> lockd: lockdsvc: invalid argument 

lockd is a kernel thread nowadays, remove it from your nfsd start script
or simply ignore the error (if you want compatibility with 2.2 kernels
before 2.2.18).

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
