Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274456AbRIYDde>; Mon, 24 Sep 2001 23:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274455AbRIYDdY>; Mon, 24 Sep 2001 23:33:24 -0400
Received: from mail01g.rapidsite.net ([207.158.192.232]:19037 "HELO
	mail01g.rapidsite.net") by vger.kernel.org with SMTP
	id <S274451AbRIYDdP>; Mon, 24 Sep 2001 23:33:15 -0400
Content-Type: text/plain; charset=US-ASCII
From: David Koretzky <david@spanware.com>
Reply-To: david@spanware.com
Organization: Spanware
To: linux-kernel@vger.kernel.org
Subject: Kernel Panic New Adaptec - Old Adaptec Works
Date: Mon, 24 Sep 2001 23:34:26 -0400
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
X-Loop-Detect: 1
Message-Id: <20010925033318Z274451-760+16507@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am running a dual PIII 933 VIA based motherboard (Gigabyte 6VXDC7). 
I have two Seagate Cheetah HDs, and two SCSI cdroms.  There are no IDE 
devices anywhere in the system, and no support is compiled in the kernel or 
as a module for IDE.

Kernel 2.4.7 works perfectly.  I cannot get 2.4.10 to work with the new aha 
driver compiled into the kernel.  Below is what I was able to capture of the 
output 

Disconnected List inconsistency. SCB index == 255, yet numscbs=4.scsi0

Dumping card state while ide, at SEQADDR 0x1a5

ACCNUM=0x0
SINDEX=0x0
DINDEX=0x0
ARG_2=0x7f
HCNT=0x0
SCSI SEQ=0x12 SBLKCTL=0xa
DFNCTRL=0x0 DFSTATUS=0x89
LAST PHASE=0x1 SCSISIGI=0x0 SXFRCTL0=0x88

SSTAT0=0x0
SSTAT1=0x0
STACK=0x0, 0x0, 0x0, 0x0
SCB_COUNT=4
KERNEL NEXTQSCB=3
CARD NEXTQSCB=3

QINFIFO Entries: Waiting Queue Entries: Disconnected Queue Entries:
0:255...31:255

QOUTFIFO entries:
Sequencer Free SCB List:
0...31

Pending List:
Kernel Free SCB List: 2 1 0
Kernel Panic : For Safety

I am currently running 2.4.10 with the old Doug Ledford driver, and it works 
perfectly.

P.S. Could you please CC me any help?

Thank you.

-- 

David Koretzky
david@spanware.com
