Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269413AbRHCPgU>; Fri, 3 Aug 2001 11:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269408AbRHCPgK>; Fri, 3 Aug 2001 11:36:10 -0400
Received: from [213.11.85.133] ([213.11.85.133]:4371 "EHLO titane.novadeck.net")
	by vger.kernel.org with ESMTP id <S269414AbRHCPgD>;
	Fri, 3 Aug 2001 11:36:03 -0400
Message-Id: <200108031534.f73FYFY32370@titane.novadeck.net>
Content-Type: text/plain; charset=US-ASCII
From: sunnox <pn@novadeck.net>
Reply-To: pn@novadeck.net
Organization: Novadeck
To: linux-kernel@vger.kernel.org
Subject: NFS Root problem
Date: Fri, 3 Aug 2001 17:31:36 +0200
X-Mailer: KMail [version 1.3]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a diskless workstation that is mounting is root partition from an NFS3 
server.
But each time the diskless workstation is mounting the root partion with 
NFSv2 and not 3
And mount /home partition in NFSv3
See:
http1:~# mount 
/dev/root on / type nfs 
(rw,v2,rsize=4096,wsize=4096,hard,udp,nolock,addr=10.0.7.1) none on /proc 
type proc (rw) devpts on /dev/pts type devpts (rw) 10.0.7.1:/home on /home 
type nfs (rw,v3,rsize=8192,wsize=8192,hard,udp,nolock,addr=10.0.7.1)

My configuration:

NFS server

linux 2.4.7+GFS patch
nfs-utils-0.3.1
util-linux-2.11h.tar.gz

NFS client

linux 2.4.7+ NFS client patch (all)

The root partition mounted from the diskless client is a GFS partition 
The /home partion mounted from the diskless client is a reiserfs partition

Thanks for any help
