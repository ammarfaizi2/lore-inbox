Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271436AbRHOUyh>; Wed, 15 Aug 2001 16:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271438AbRHOUy1>; Wed, 15 Aug 2001 16:54:27 -0400
Received: from msgbas1tx.cos.agilent.com ([192.6.9.34]:60900 "HELO
	msgbas1t.cos.agilent.com") by vger.kernel.org with SMTP
	id <S271436AbRHOUyJ>; Wed, 15 Aug 2001 16:54:09 -0400
Message-ID: <FEEBE78C8360D411ACFD00D0B7477971880B2F@xsj02.sjs.agilent.com>
From: "MEHTA,HIREN (A-SanJose,ex1)" <hiren_mehta@agilent.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: problem with LILO : junk characters before "boot:"
Date: Wed, 15 Aug 2001 14:54:15 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi List,

I am trying to boot from a scsi drive through LILO.
at the LILO prompt, I get something like this :

LILO
xB.=!rFxxBoot:                   (where x is a some non-ascii character).

After that it gives me a list of kernels to boot from.
If I press "Enter", I get Error 0x40 or 0x80.
Also, I just see only "Read Capacity" commands being issued to the drive
continuously. 

Can somebody tell me what the prblem is ? Is there any problem with
partition
table on the disk ? Or is the Lilo corrupted ? 

I tried to re-run lilo again after going into the "rescue" mode. Is there
any other way that I can re-install the LILO ?

Thanks and regards,
-hiren
