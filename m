Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263909AbTEFPtf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 11:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263911AbTEFPtf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 11:49:35 -0400
Received: from smtp018.mail.yahoo.com ([216.136.174.115]:28435 "HELO
	smtp018.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263909AbTEFPtc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 11:49:32 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: "Lever, Charles" <Charles.Lever@netapp.com>
Subject: Re: [NFS] processes stuck in D state
Date: Tue, 6 May 2003 17:56:24 +0200
User-Agent: KMail/1.5.1
References: <482A3FA0050D21419C269D13989C611312747A@lavender-fe.eng.netapp.com>
In-Reply-To: <482A3FA0050D21419C269D13989C611312747A@lavender-fe.eng.netapp.com>
Cc: <nfs@lists.sourceforge.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       "Zeev Fisher" <Zeev.Fisher@il.marvell.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200305061756.36568.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tuesday 06 May 2003 17:47, Lever, Charles wrote:
> does the problem persist after you reconnect the network cable?
> what happens when the server becomes available again?

no. If server is available again, the process wakes up from D.

But like man mount says:
[snip] The process cannot be interrupted or killed unless you also specify intr. [/snip]
The process should be killable while the cable is pulled.
But that's not the case, although intr is in fstab.

> are you mounting with UDP or TCP?

uh. How to find it out? :)

- -- 
Regards Michael Büsch
http://www.8ung.at/tuxsoft
 17:53:19 up  1:44,  5 users,  load average: 1.04, 1.05, 1.06
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+t9s0oxoigfggmSgRAkDPAKCFMeEGvS3KUhwn0bNQngKRK6h2fwCdEcv/
U2ttfZ6Mm8Sazuksfn4UUrY=
=M5Kh
-----END PGP SIGNATURE-----

