Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129170AbQKOVbW>; Wed, 15 Nov 2000 16:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129178AbQKOVbN>; Wed, 15 Nov 2000 16:31:13 -0500
Received: from synapse.onesecure.com ([64.160.160.34]:21964 "HELO
	synapse.onesecure.com") by vger.kernel.org with SMTP
	id <S129170AbQKOVax>; Wed, 15 Nov 2000 16:30:53 -0500
Date: Wed, 15 Nov 2000 13:00:37 -0800 (PST)
From: beldridg@best.com
To: linux-kernel@vger.kernel.org
Subject: mp3 problems on nfs mount
Message-ID: <Pine.LNX.4.21.0011151254310.26426-100000@rush>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

summary: can't play mp3 files on nfs mounted partition. the music starts
to play and then hangs after about 5 seconds. using xmms on the nfs
client.

leeloo (2.2.17) is the NFS server:

[root@leeloo /root]# exportfs 
/usr/local/mp3 rush

rush (2.4.10-test10) is the NFS client:

[root@rush mp3]# mount -t nfs
192.168.1.50:/usr/local/mp3 on /mnt/mp3 type nfs (rw,addr=192.168.1.50)

i've tried mounting with different rsize,wsize values, but no luck. i've
also tried mounting via SMB and have the same problems.

any ideas?


- brett


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
