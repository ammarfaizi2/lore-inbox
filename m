Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263761AbTETSF2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 14:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263763AbTETSF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 14:05:28 -0400
Received: from smtp012.mail.yahoo.com ([216.136.173.32]:14862 "HELO
	smtp012.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263761AbTETSF1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 14:05:27 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: David Balazic <david.balazic@uni-mb.si>
Subject: Re: Wrong clock initialization
Date: Tue, 20 May 2003 20:17:54 +0200
User-Agent: KMail/1.5.1
References: <3ECA673F.7B3FB388@uni-mb.si>
In-Reply-To: <3ECA673F.7B3FB388@uni-mb.si>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200305202018.16062.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tuesday 20 May 2003 19:34, David Balazic wrote:
> Hi!
>
> When the kernel is booted ( ia32 version at least ) , it reads
> the time from from the hardware CMOS clock , _assumes_ it is in
> UTC and set the system time to it.
>
> As almost nobody runs their clock in UTC, this means that the system
> is running on wrong time until some userspace tool corrects it.
>
> This can lead to situtation when time goes backwards :
>
> timezone is 2hours east of UTC.
> UTC time : 20:00
> local time : 22:00
>
> System time between boot and userspace fix : 22:00UTC
> System time after fix : 20:00UTC
>
> Comments ?

Why don't you simply set your CMOS clock to UTC?

- -- 
Regards Michael Büsch
http://www.8ung.at/tuxsoft
 20:16:51 up  4:12,  2 users,  load average: 1.00, 1.07, 1.24

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+ynFooxoigfggmSgRAopWAJ0YOxEJ5jA3sfNhDwbSHmM5Z2nJQACcDxad
+25XjbOyOGRKYUMtdQtv6mI=
=jE5A
-----END PGP SIGNATURE-----

