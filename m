Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129930AbRBIEcO>; Thu, 8 Feb 2001 23:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129951AbRBIEcE>; Thu, 8 Feb 2001 23:32:04 -0500
Received: from brooks.civeng.adelaide.edu.au ([129.127.78.254]:26756 "EHLO
	brooks.civeng.adelaide.edu.au") by vger.kernel.org with ESMTP
	id <S129930AbRBIEba>; Thu, 8 Feb 2001 23:31:30 -0500
From: "Stephen Carr" <sgcarr@civeng.adelaide.edu.au>
To: linux-kernel@vger.kernel.org
Date: Fri, 9 Feb 2001 14:58:24 +1030
Subject: Panic in 2.2.2-pre2 SMP several panics
Reply-to: sgcarr@civeng.adelaide.edu.au
Message-ID: <3A840590.11464.D9B937@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Kernel Gurus

Sorry if this is a bit of a repeat - I think the prior message was 
incorrectly addressed.

System Dual 500 Mhz Pentium III 256MB ram with Adaptec 2940 
UW scsi controller - WD disc and HP DAT tape.

I have been getting kernel panics when doing backups over the 
network. I have used both the eepro100 driver and Intel's e100 driver 
the general type of error is a panic - Aiee -- killing the interrupt 
driver.

I have tried the 2.4.0, 2.4.1 and lately the 2.2.2-pre2 kernels.

Panics below for 2.4.2-pre2 kernel.

The error I have got is spkput:over: d0826d4b put:1514 dev:eth0 
kernel BUG at skbuff.c:93 using the e100 driver

The NIC is an Intel Ether ExpressPro 100 set to 100Mbs full duplex 
connected to an HP2424M switch.

I switched to the eepro100 drive and got this panic with system 
"idle" and I was typing sudo -s.

Unable to handle kernel paging request at virtual address 18000080 
Bad EIP value. Killing the interrupt handler.

Any ideas?

Stephen Carr


-----------------
Computing Officer
Department of Civil and Environmental Engineering
University of Adelaide
Adelaide, South Australia,
Australia 5005
Phone +618 8303-4313
Fax   +618 8303-4359
Email sgcarr@civeng.adelaide.edu.au
-----------------------------------------------------------
This email message is intended only for the addressee(s)
and contains information which may be confidential and/or
copyright.  If you are not the intended recipient please
do not read, save, forward, disclose, or copy the contents
of this email. If this email has been sent to you in error,
please notify the sender by reply email and delete this
email and any copies or links to this email completely and
immediately from your system.  No representation is made
that this email is free of viruses.  Virus scanning is
recommended and is the responsibility of the recipient.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
