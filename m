Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262272AbSIZKVa>; Thu, 26 Sep 2002 06:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262273AbSIZKV3>; Thu, 26 Sep 2002 06:21:29 -0400
Received: from mx0.gmx.de ([213.165.64.100]:2639 "HELO mx0.gmx.net")
	by vger.kernel.org with SMTP id <S262272AbSIZKV3>;
	Thu, 26 Sep 2002 06:21:29 -0400
Date: Thu, 26 Sep 2002 12:26:40 +0200 (MEST)
From: Marco Schwarz <marco.schwarz@gmx.net>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
References: <20020926095957.GC42048@niksula.cs.hut.fi>
Subject: Serious Problems with diskless clients
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0012086198@gmx.net
X-Authenticated-IP: [153.95.95.95]
Message-ID: <3489.1033036000@www51.gmx.net>
X-Mailer: WWW-Mail 1.5 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

my diskless clients have some severe problems on one of my servers.
Sometimes (right now most of the time) everything just hangs at the same place when
starting up the kernel. Here are the last messages I get (right before this
IP-Config is running and looks OK):

NET4: Unix domain sockets 1.0/SMP for Linux NET4.0
ds: no socket drivers loaded !
Looking up port of RPC 100003/2 on 192.168.0.235
portmap: server 192.168.0.235 mot responding, timed out !
Root-NFS: Unable to get nfsd port number from server, using default
Looking up port of RPC 100005/1 on 192.168.0.235
portmap: server 192.168.0.235 mot responding, timed out !
Root-NFS: Unable to get mountd port number from server, using default
mount: server 192.168.0.235 not responding, timed out
Root-NFS: Server returned error -5 while mounting /netclients/192.168.0.87
VFS: Unable to mount root fs via NFS, trying floppy
VFS: Insert root floppy and press ENTER

I am thinking right now that we have some problems with network hardware,
but maybe its a Software problem. Could someone tell me what the 'Looking up
port of RPC 100003/2 on 192.168.0.235' in kernel startup is doing an why it
could fail ?

We have Kernel 2.4.10 on both server and clients (I also tried 2.4.19, but
it changed nothing).

Thanks,
Marco Schwarz

