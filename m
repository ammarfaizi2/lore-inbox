Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264184AbTEaSL2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 14:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264383AbTEaSL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 14:11:27 -0400
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:13061 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264184AbTEaSL0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 14:11:26 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: pdflush -> noflushd related question
Date: Sat, 31 May 2003 20:24:52 +0200
User-Agent: KMail/1.5.2
References: <200305311841.59599.fsdeveloper@yahoo.de> <20030531105850.7cc92601.akpm@digeo.com>
In-Reply-To: <20030531105850.7cc92601.akpm@digeo.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200305312024.52920.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Saturday 31 May 2003 19:58, Andrew Morton wrote:
> Michael Buesch <fsdeveloper@yahoo.de> wrote:
> >  So, how to set the interval, or better sayed, how to _stop_
> >  buffer flushing in 2.5?
>
> /proc/sys/vm has the appropriate tunables.  They are documented in
> Documentation/filesystems/proc.txt.
>
> You can turn these guys off by setting the sysctls to 1000000000
> I guess.   Problem is, I don't think there's a way of starting them
> again until the ten million seconds expires.  hmm.

Thanks Andrew, that's a good point to goon hacking. :)
I'll look at it.

- -- 
Regards Michael Büsch
http://www.8ung.at/tuxsoft
 20:21:50 up  5:54,  2 users,  load average: 2.01, 2.02, 2.00

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+2PN0oxoigfggmSgRArlBAJ9zZBsnnAjTA8s6cTK7xPeFDM+v+wCffyE/
fLHzyat7wxgEu1902BYQtUg=
=eq9e
-----END PGP SIGNATURE-----

