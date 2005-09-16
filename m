Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965308AbVIPTmH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965308AbVIPTmH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 15:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965312AbVIPTmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 15:42:07 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:24019 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S965308AbVIPTmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 15:42:05 -0400
Message-Id: <200509161941.j8GJfhK7016159@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Nix <nix@esperi.org.uk>,
       arjanv@redhat.com, Linux kernel <linux-kernel@vger.kernel.org>,
       ivan.korzakow@gmail.com, fawadlateef@gmail.com
Subject: Re: best way to access device driver functions 
In-Reply-To: Your message of "Fri, 16 Sep 2005 15:20:12 EDT."
             <Pine.LNX.4.61.0509161512350.5140@chaos.analogic.com> 
From: Valdis.Kletnieks@vt.edu
References: <a5986103050915004846d05841@mail.gmail.com> <1e62d137050915010361d10139@mail.gmail.com> <a598610305091505184a8aa8fd@mail.gmail.com> <1e62d13705091508391832f897@mail.gmail.com> <87mzmduq1h.fsf@amaterasu.srvr.nix> <1126879660.3103.6.camel@localhost.localdomain> <87irx1ujc0.fsf@amaterasu.srvr.nix> <Pine.LNX.4.61.0509161133410.2041@chaos.analogic.com> <5162CC44-37D0-4FEB-ADC6-887F6FC3C3BA@mac.com>
            <Pine.LNX.4.61.0509161512350.5140@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1126899702_3550P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 16 Sep 2005 15:41:43 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1126899702_3550P
Content-Type: text/plain; charset=us-ascii

On Fri, 16 Sep 2005 15:20:12 EDT, "linux-os (Dick Johnson)" said:

> from inside the company. If the list keeper followed the recommended
> email procedure of ignoring everything after a "." in the first
> column, something that is as old as email itself, then there would
> not be any of the crap that a lot of emailers append.

Actually, what RFC821 actually *said* clear back in August 1982 was:

      4.5.2.  TRANSPARENCY

         Without some provision for data transparency the character
         sequence "<CRLF>.<CRLF>" ends the mail text and cannot be sent
         by the user.  In general, users are not aware of such
         "forbidden" sequences.  To allow all user composed text to be
         transmitted transparently the following procedures are used.

            1. Before sending a line of mail text the sender-SMTP checks
            the first character of the line.  If it is a period, one
            additional period is inserted at the beginning of the line.

            2. When a line of mail text is received by the receiver-SMTP
            it checks the line.  If the line is composed of a single
            period it is the end of mail.  If the first character is a
            period and there are other characters on the line, the first
            character is deleted.

I think you're confusing this with the behavior of the BSD 'mail' command,
which would treat a lone '.' as "end of message" *as part of the user interface*.
Apparently, at least one Unix vendor also shipped a brain-dead Sendmail that
was configured to *not* dot-stuff an SMTP connection by default.

In other words, if that '.' *ever* made the rest of the message dissapear, it
was due to either a *local* UI quirk or an outright *bug*.            


--==_Exmh_1126899702_3550P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDKx/2cC3lWbTT17ARAvJHAJ9zdv704FcSBOFLPjSt6mrTWcvxHgCaAlS7
XjaE7hyRBhTNDAs8LClvdoI=
=HBVw
-----END PGP SIGNATURE-----

--==_Exmh_1126899702_3550P--
