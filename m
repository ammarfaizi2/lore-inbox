Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130093AbRBASiV>; Thu, 1 Feb 2001 13:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129730AbRBASiL>; Thu, 1 Feb 2001 13:38:11 -0500
Received: from msgbas1tx.cos.agilent.com ([192.6.9.34]:9931 "HELO
	msgbas1t.cos.agilent.com") by vger.kernel.org with SMTP
	id <S130601AbRBASiE>; Thu, 1 Feb 2001 13:38:04 -0500
Message-ID: <FEEBE78C8360D411ACFD00D0B747797188097A@xsj02.sjs.agilent.com>
From: hiren_mehta@agilent.com
To: linux-kernel@vger.kernel.org
Subject: problem with devfsd compilation
Date: Thu, 1 Feb 2001 11:37:59 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am trying to compile devfsd on my system running RedHat linux 7.0
(kernel 2.2.16-22). I get the error "RTLD_NEXT" undefined. I am not
sure where this symbol is defined. Is there anything that I am missing 
on my system. 

Also, I applied the devfs patch to the kernel, installed the new
kernel, modified lilo.conf, ran lilo and rebooted the system
with the  option "devfs=nomount". The system is able to mount
the root file system in readonly mode. But after that when
it tries to do fsck to the root file system before mounting 
it in "rw" mode, it fails. Looks like devfs seems to be
having a problem with my /etc/fstab. My /etc/fstab has device names
specified in the "LABEL=.." format. Does devfs understand LABEL=..
format ?

Any help is appreciated.

-hiren
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
