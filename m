Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311898AbSEaANA>; Thu, 30 May 2002 20:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312560AbSEaAM7>; Thu, 30 May 2002 20:12:59 -0400
Received: from libera.host4u.net ([216.71.64.60]:9993 "EHLO libera.host4u.net")
	by vger.kernel.org with ESMTP id <S311898AbSEaAM5>;
	Thu, 30 May 2002 20:12:57 -0400
Date: Thu, 30 May 2002 19:12:48 -0500 (CDT)
From: Ed Carp <ranger!erc@adsl-61-76-31.pns.bellsouth.net>
X-X-Sender: erc@ranger.pns.bellsouth.net
Reply-To: erc@pobox.com
To: linux-kernel@vger.kernel.org
Subject: Is the linux networking code broken?
Message-ID: <20020530190845.N371-100000@ranger.pns.bellsouth.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Or have I been smoking too much crack? ;)

I've tried this code on several different linux machines, running 2.0.36 -
2.4.7 kernels, and it always acts the same.  Doing a write() of more than
1024 bytes on a TCP socket always disables all network connectivity on the
sending machine.  (A reboot fixes things, naturally).  I've tried the same
code on FreeBSD 4.5 machines with no problems.  Is this a limitation in
the kernel networking code, in the IP fragmentation layer, or what?  I'm
scratching my head here...thanks in advance for any replies.  Off-list, if
you would be so kind...
- -- 
Ed Carp, N7EKG          http://www.pobox.com/~erc               214/986-5870
Director, Software Development
Escapade Server-Side Scripting Engine Development Team
Pensacola - Dallas - London - Dresden
http://www.squishedmosquito.com


-----BEGIN PGP SIGNATURE-----
Version: PGP 6.5.8
Comment: Made with pgp4pine 1.76

iQA/AwUBPPax+EbhwAGg7YRjEQK6ogCcCldlimuRlXlHMp5ltTgCycE3B7EAoNwo
QunzakQoiAMJyaWm8qyZi1RB
=qbSK
-----END PGP SIGNATURE-----


