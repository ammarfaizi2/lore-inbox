Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262187AbTCMHTP>; Thu, 13 Mar 2003 02:19:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262190AbTCMHTP>; Thu, 13 Mar 2003 02:19:15 -0500
Received: from pop.gmx.de ([213.165.64.20]:28111 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S262187AbTCMHTO> convert rfc822-to-8bit;
	Thu, 13 Mar 2003 02:19:14 -0500
Content-Type: text/plain; charset=US-ASCII
From: Torsten Foertsch <torsten.foertsch@gmx.net>
To: "Jeremy Booker" <JerMe@nc.rr.com>
Subject: Re: initrd / pivot_root + boot problems
Date: Thu, 13 Mar 2003 08:29:26 +0100
User-Agent: KMail/1.4.3
References: <002801c2e8ea$46aadfb0$6401a8c0@jeremy>
In-Reply-To: <002801c2e8ea$46aadfb0$6401a8c0@jeremy>
Cc: <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200303130829.29989.torsten.foertsch@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wednesday 12 March 2003 23:54, Jeremy Booker wrote:
> kernel /boot/vmlinuz-2.4.7-10 ro root=/dev/sda1

append to that line "init=/bin/bash" then boot. You will see a bash prompt.
Now mount whatever is necessary, change your passwd and reboot. Maybe, you 
need a "mount -o remount,rw /" prior to changing pw.


Torsten
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE+cDNZwicyCTir8T4RAoNmAKCR2BQI0NulQ8vNebNJGHKYu2xuPwCcDiCu
HMkno8ozAKjKk8Xll/WRqBM=
=puKa
-----END PGP SIGNATURE-----
