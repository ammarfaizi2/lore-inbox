Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280738AbRKGM7Y>; Wed, 7 Nov 2001 07:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280749AbRKGM7P>; Wed, 7 Nov 2001 07:59:15 -0500
Received: from mailgate.globalintranet.net ([194.206.181.247]:17860 "EHLO
	relais-int9.globalintranet.net") by vger.kernel.org with ESMTP
	id <S280738AbRKGM65>; Wed, 7 Nov 2001 07:58:57 -0500
Subject: Pb with ipcs limits
To: linux-kernel@vger.kernel.org
From: Christian-R.DAVID@pechiney.com
Date: Wed, 7 Nov 2001 13:58:41 +0100
Message-ID: <OF6DDE7396.771A7879-ONC1256AFD.00467698@ftgin.net>
X-MIMETrack: Serialize by Router on PE01PIVOT/PECHINEY(Release 5.0.6a |January 17, 2001) at
 07/11/2001 13:59:32
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a little pb with the system V ipc.

The configuration of my system is:

"ipcs -l" gives me:

------ Shared Memory Limits --------
max number of segments = 128
max seg size (kbytes) = 32768
max total shared memory (kbytes) = 16777216
min seg size (bytes) = 1

------ Semaphore Limits --------
max number of arrays = 128
max semaphores per array = 32
max semaphores system wide = 4096
max ops per semop call = 32
semaphore max value = 32767

------ Messages: Limits --------
max queues system wide = 128
max size of message (bytes) = 4056
default max size of queue (bytes) = 16384

I would like to grow-up the default max size of queue (bytes) to 65536.
How can i do ?

I try to change the kernel-source but it doesn't work fine!!!!!

PS: I hope my question is not so stupid and thanks for all answers.

