Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290925AbSASIl7>; Sat, 19 Jan 2002 03:41:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290926AbSASIlk>; Sat, 19 Jan 2002 03:41:40 -0500
Received: from dsl-213-023-060-177.arcor-ip.net ([213.23.60.177]:40710 "HELO
	spot.local") by vger.kernel.org with SMTP id <S290925AbSASIl0>;
	Sat, 19 Jan 2002 03:41:26 -0500
Date: Sat, 19 Jan 2002 09:44:24 +0100
From: Oliver Feiler <kiza@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Removing files in devfs
Message-ID: <20020119094424.A239@gmxpro.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Operating-System: Linux 2.4.16 i686
X-Species: Snow Leopard
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	Is this behaviour supposed to be?

9:36 root@kiza /dev# l null 
crw-rw-rw-    1 root     root       1,   3 Jan  1  1970 null
9:36 root@kiza /dev# rm null
removing `null'
9:36 root@kiza /dev# l null
ls: null: No such file or directory
9:36 root@kiza /dev#

	I have kernel 2.4.16 with devfs and on every other system I tried I 
only get "rm: cannot unlink `null': Operation not permitted" when trying to 
delete something in devfs. And I cannot see any differences as far as devfs is 
concerned on the systems I tried. devfs compiled in, mounted on boot time, 
same version of devfsd.

Regards,

Oliver

-- 
Oliver Feiler                                               kiza@gmx.net
http://www.lionking.org/~kiza/pgpkey              PGP key ID: 0x561D4FD2
http://www.lionking.org/~kiza/
