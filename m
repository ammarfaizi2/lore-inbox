Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265070AbTFCPov (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 11:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265071AbTFCPou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 11:44:50 -0400
Received: from smtp808.mail.sc5.yahoo.com ([66.163.168.187]:15959 "HELO
	smtp808.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265070AbTFCPoq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 11:44:46 -0400
From: Bob Johnson <livewire@gentoo.org>
Reply-To: livewire@gentoo.org
To: "Wm. Josiah Erikson" <josiah@insanetechnology.com>
Subject: Re: siimage driver status
Date: Tue, 3 Jun 2003 10:58:06 -0500
User-Agent: KMail/1.5.2
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0306031127450.23499-100000@bork.hampshire.edu>
In-Reply-To: <Pine.LNX.4.44.0306031127450.23499-100000@bork.hampshire.edu>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200306031058.10447.livewire@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

yes, ive always added -X66 , the only way to not lock is a trick from siimages 
site (think it was in a mandrake script)
echo "max_kb_per_request:15" > /proc/ide/hde/settings

The lockup also happens in latest 2.5 kernels, which the above command
is only for 2.4.

On Tuesday 03 June 2003 10:29 am, Wm. Josiah Erikson wrote:
> Does this still happen? It used to happen to me, but as soon as I added

> -X66, per Alan's suggestion, everything is fine.
> 	-Josiah (currently in the middle of writing 36GB to a two-drive
> RAID 0 array on a sil3112 controller and everything is peachy - fast as
> HELL, actually - grin - I've never seen over 100MB/sec off a RAID 0 of two
> drives before)
>
>
> On Tue, 3 Jun 2003, Bob Johnson wrote:
>
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Has anything been addressed to help the instant lock up when enabling dma
> that alot of users are reporting?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+3MWSxJgsCy9JAX0RAlpwAJ9Q0Pmz1Xda8tCvmuVjV21G8oDwAgCbBKzI
e6707tgTmA2nQKlfsVvr/pw=
=Ct7+
-----END PGP SIGNATURE-----

