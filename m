Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136462AbREIOCf>; Wed, 9 May 2001 10:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136464AbREIOC0>; Wed, 9 May 2001 10:02:26 -0400
Received: from bugs.unl.edu.ar ([168.96.132.208]:45735 "HELO bugs.unl.edu.ar")
	by vger.kernel.org with SMTP id <S136462AbREIOCJ>;
	Wed, 9 May 2001 10:02:09 -0400
Content-Type: text/plain; charset=US-ASCII
From: =?iso-8859-1?q?Mart=EDn=20Marqu=E9s?= <martin@bugs.unl.edu.ar>
To: linux-kernel@vger.kernel.org
Subject: reiserfs, xfs, ext2, ext3
Date: Wed, 9 May 2001 10:38:14 +0300
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01050910381407.26653@bugs>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We are waiting for a server with dual PIII, RAID 1,0 and 5 18Gb scsi disks to 
come so we can change our proxy server, that will run on Linux with Squid. 
One disk will go inside (I think?) and the other 4 on a tower conected to the 
RAID, which will be have the cache of the squid server.

One of my partners thinks that we should use reiserfs on all the server (the 
partitions of the Linux distro, and the cache partitions), and I found out 
that reiserfs has had lots of bugs, and is marked as experimental in kernel 
2.4.4. Not to mention that the people of RH discourage there users from using 
it.

There has also been lots of talks about reiserfs being the cause of some data 
lose and performance lose (not sure about this last one).

So what I want is to know which is the status of this 3 journaling FS. Which 
is the one we should look for?

I think that the data lose is not significant in a proxy cache, if the FS is 
really fast, as is said reiserfs is.

Saludos... :-)

-- 
El mejor sistema operativo es aquel que te da de comer.
Cuida tu dieta.
-----------------------------------------------------------------
Martin Marques                  |        mmarques@unl.edu.ar
Programador, Administrador      |       Centro de Telematica
                       Universidad Nacional
                            del Litoral
-----------------------------------------------------------------
