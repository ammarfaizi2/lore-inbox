Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129190AbQKOWs0>; Wed, 15 Nov 2000 17:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129316AbQKOWsP>; Wed, 15 Nov 2000 17:48:15 -0500
Received: from raven.toyota.com ([205.180.183.200]:39698 "EHLO
	raven.toyota.com") by vger.kernel.org with ESMTP id <S129190AbQKOWsI>;
	Wed, 15 Nov 2000 17:48:08 -0500
Message-ID: <3A130B9E.91A6B8A8@toyota.com>
Date: Wed, 15 Nov 2000 14:18:06 -0800
From: J Sloan <jjs@toyota.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: mp3 problems on nfs mount
In-Reply-To: <Pine.LNX.4.21.0011151254310.26426-100000@rush>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't have the asnwer to your particular problem,
but I can provide a data point:

I play mp3s regularly from an nfs server running 2.4.0.testx
(currently test11-pre5), with client also running 2.4.0-testx.

The mp3 directory is automounted on demand. xmms
plays these nfs-mounted mp3s for hours with no problem.

This same nfs server takes backups via tarfiles on nfs
exported volumes to a mixed bag of 2.2 and 2.4 clients.

The server is of course running the kernel-based nfsd,
and HJ Lu's nfs-utils package. (currently 0.2.1-1)

Regards,

jjs


beldridg@best.com wrote:

> summary: can't play mp3 files on nfs mounted partition. the music starts
> to play and then hangs after about 5 seconds. using xmms on the nfs
> client.
>
> leeloo (2.2.17) is the NFS server:
>
> [root@leeloo /root]# exportfs
> /usr/local/mp3 rush
>
> rush (2.4.10-test10) is the NFS client:
>
> [root@rush mp3]# mount -t nfs
> 192.168.1.50:/usr/local/mp3 on /mnt/mp3 type nfs (rw,addr=192.168.1.50)
>
> i've tried mounting with different rsize,wsize values, but no luck. i've
> also tried mounting via SMB and have the same problems.
>
> any ideas?
>
> - brett
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
