Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263181AbTIVO4j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 10:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263183AbTIVO4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 10:56:20 -0400
Received: from mail.somanetworks.com ([216.126.67.42]:17569 "EHLO
	mail.somanetworks.com") by vger.kernel.org with ESMTP
	id S263181AbTIVO4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 10:56:13 -0400
Date: Mon, 22 Sep 2003 10:56:08 -0400
From: Georg Nikodym <georgn@somanetworks.com>
To: Julian Blake Kongslie <jblake@omgwallhack.org>
Cc: bcollins@debian.org, linux-kernel <linux-kernel@vger.kernel.org>,
       linux1394-devel@lists.sourceforge.net
Subject: Re: Problem with ohci1394/sbp2
Message-Id: <20030922105608.529c4669.georgn@somanetworks.com>
In-Reply-To: <1063909274.1253.12.camel@festa.omgwallhack.org>
References: <1063909274.1253.12.camel@festa.omgwallhack.org>
Organization: SOMA Networks
X-Mailer: Sylpheed version 0.9.5claws (GTK+ 1.2.10; i386-pc-linux-gnu)
X-Face: #EE>^U0b8z^y>O0BZ>JJMGXyyxSP?<W-(g1&Yh;2p1'N6AeM]{Zfu(v>Uhe8ptGua4P}`QZ
 m%yb7CYwN^TiGQcP&mncyDrjAtLh7cB|m{$C,ww;yaYi*YvQllxb*vet
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="Multipart_Mon__22_Sep_2003_10_56_08_-0400_3W=.TOzomg7=cBhS"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Multipart_Mon__22_Sep_2003_10_56_08_-0400_3W=.TOzomg7=cBhS
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Thu, 18 Sep 2003 11:21:14 -0700
Julian Blake Kongslie <jblake@omgwallhack.org> wrote:

[data elided...]

> I cannot access the drive - it is not shown in /proc/scsi/scsi, there
> are no devices for it in /dev/scsi.
> 
> I am running without ACPI, without APIC, with APM, on a
> single-processor Intel Pentium 3 machine.

I have similar problems (in that at some point, the kernel decides it
cannot talk to the disk).  I have a similar config except that I do not
compile any of the 1394 stuff as modules.

> This drive works perfectly in 2.4.22, and in Windows.

Ditto (but that I don't run Windows).  This problem has sent me back to
2.6.0-test4 (where my FW works).

-g

--Multipart_Mon__22_Sep_2003_10_56_08_-0400_3W=.TOzomg7=cBhS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/bw2LoJNnikTddkMRAomSAJ9iaUPYDlftkMqY+cjAUNCC2kvfLACfWihd
1JTZHYaHKvbJV9NemKscFGk=
=1j3w
-----END PGP SIGNATURE-----

--Multipart_Mon__22_Sep_2003_10_56_08_-0400_3W=.TOzomg7=cBhS--
