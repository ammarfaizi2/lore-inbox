Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271244AbRHZCLJ>; Sat, 25 Aug 2001 22:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271246AbRHZCK7>; Sat, 25 Aug 2001 22:10:59 -0400
Received: from bryansk-lan-murka.pptus.ru ([212.73.98.249]:37124 "HELO
	bryansk.pptus.ru") by vger.kernel.org with SMTP id <S271244AbRHZCKu>;
	Sat, 25 Aug 2001 22:10:50 -0400
Content-Type: text/plain; charset=US-ASCII
From: Reaper <temp4r@mail.chat.ru>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.4.8-ac11 and VFAT issues
Date: Sun, 26 Aug 2001 06:11:59 +0400
X-Mailer: KMail [version 1.3]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010826021049.26A83229BE@bryansk.pptus.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On my box VFAT partitions are mounted with options
 noexec,umask=0,codepage=866,iocharset=koi8-r,quiet.
With kernel 2.4.8-ac11 there is a problem:
 executable flag is not cleared for files on VFAT.
 They all are executable and "noexec" in fstab is just ignored.
On 2.4.7-ac9 all ok.
Any suggestions?
- -- 
Best regards, Yuri Borunov.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7iFr4yttlzqtJmncRAqR2AKCvlydS/y81cfivlw0seCWCgMtbwACeMqru
O2JqM6B58eADS2PAZmJbvoc=
=l32B
-----END PGP SIGNATURE-----
