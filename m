Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273021AbTHFW3j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 18:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274957AbTHFW2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 18:28:36 -0400
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:62724 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id S273021AbTHFW2G convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 18:28:06 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: gardiol@libero.it
Subject: Re: [2.6] system is very slow during disk access
Date: Thu, 7 Aug 2003 00:27:34 +0200
User-Agent: KMail/1.5.3
References: <200308062052.10752.fsdeveloper@yahoo.de> <200308062131.46017.fsdeveloper@yahoo.de> <200308070019.17442.gardiol@libero.it>
In-Reply-To: <200308070019.17442.gardiol@libero.it>
Cc: Frank Van Damme <frank.vandamme@student.kuleuven.ac.be>,
       linux-ide@vger.kernel.org,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200308070027.59570.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thursday 07 August 2003 00:19, Willy Gardiol wrote:
> Try to unmask IRQ, this should realy help...
> hdparm -u1 /dev/hda
>
> I usually do on my disks:
> hdparm -c1 -u1 -d1 -X69 /dev/hda
> (note: use -X69 only for for an UDMA 100 or 133 drive)

Thanks, -u1 -X69 helps a bit, but the core-problem is still
there. The system still doesn't respond as it should.
It's better, but it's not good.

I'll try to profile, as Andrew said.

- -- 
Regards Michael Buesch  [ http://www.8ung.at/tuxsoft ]
Penguin on this machine:  Linux 2.6.0-test2 - i386

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/MYDtoxoigfggmSgRAjWCAJ9ro9WuEKVFZ7GK8L/6Yu2Dyx3KZQCgilht
Rtrimh4NthabJn3v3l2siJc=
=/vr8
-----END PGP SIGNATURE-----

