Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314243AbSF2UD1>; Sat, 29 Jun 2002 16:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314278AbSF2UD0>; Sat, 29 Jun 2002 16:03:26 -0400
Received: from niobium.golden.net ([199.166.210.90]:64239 "EHLO
	niobium.golden.net") by vger.kernel.org with ESMTP
	id <S314243AbSF2UDY>; Sat, 29 Jun 2002 16:03:24 -0400
Date: Sat, 29 Jun 2002 16:04:23 -0400
From: "John L. Males" <jlmales@yahoo.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Kernel 2.2.21 aic7xxx lockup or kernel lockup
Message-Id: <20020629160423.2cfc6be7.jlmales@yahoo.com>
Reply-To: jlmales@yahoo.com
Organization: Toronto, Ontario - Canada
X-Mailer: Sylpheed version 0.7.8 (GTK+ 1.2.10; i586-pc-linux-gnu-Patched-SortRecipient-CustomSMTPAuthNDate)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.5HF0A(gPDDs6qU"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.5HF0A(gPDDs6qU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello,

**** Please BCC me in on any reply, not CC me.
Two reasons, I am not on the Mailing List,
and second I am suffering BIG time with SPAM
from posting to mailing lists/Newsgroups.
Instructions on real address at bottom.
Thanks in advance. *****

Could somone advise me what I need to do to obtain the details of a
aic7xxx module lockup that happens when using insmod?  I am not sure
what would be helpful data to report here and assist in determining
what is the problem, beyond the obvious system details?

I am now using kernel 2.2.21, and it is a tad better in terms of not
locking up the kernel hard in the different device connected
conditions.  The lockup does not always occur, much depends on if
something is connected to the 2930 or not.  In all cases with a device
connected a hard kernel lockup or module load lockup occur.  In the
latter I can ctrl-c or close the xterm to kill the load.  I tried an
strace but this appears not to provide any detail, at least in my
limited knowledge of the kernel and my techncial read of the strace
data.

The 2930 has no problem with seeing the devices.  The devices work
just fine as I changed to a BusLogic 930 and both scanner and CDWriter
work just fine.  The primary SCSI is a Buslogic 958 that the hard
drives boot off.  I was using the 2930 for external and slow devices. 
The 958 remained in, I just swapped the 2930 for the 930.  The
buslogic.o is loaded at boot time from the Initial RAM disk, and there
is no compiled in SCSI driver support, all are modules.

I really appreciate if you bcc me in on your reply so I can avoid the
big SPAM problems that have been snowballing me lately.


Regards,

John L. Males
Willowdale, Ontario
Canada
29 June 2002 16:04


==================================================================


"Boooomer ... Boom Boom, how are you Boom Boom" Boomer 1985 -
February/2000


***** Please BCC me in on any reply, not CC me.
Two reasons, I am not on the Mailing List,
and second I am suffering BIG time with SPAM
from posting to mailing lists/Newsgroups.
Instructions on real address at bottom.
Thanks in advance. *****


Please BCC me by replacing after the "@" as follows:
TLD =         The last three letters of the word "internet"
Domain name = The first four letters of the word "software",
              followed by the first four letters of the word
              "homeless".
My appologies in advance for the jumbled eMail address
and request to BCC me, but SPAM has become a very serious
problem.  The eMail address in my header information is
not a valid eMail address for me.  I needed to use a valid
domain due to ISP SMTP screen rules.

--=.5HF0A(gPDDs6qU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iEYEARECAAYFAj0eEt4ACgkQsrsjS27q9xaWvQCcCcjZZGVHhm7EhD6Etr0QhCqw
/YgAnjHr4SAc/rRSUWITkvkW6oI33o8m
=gu8K
-----END PGP SIGNATURE-----

--=.5HF0A(gPDDs6qU--

