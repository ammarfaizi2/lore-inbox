Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265671AbSIRGqN>; Wed, 18 Sep 2002 02:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265675AbSIRGqN>; Wed, 18 Sep 2002 02:46:13 -0400
Received: from mailhost.uni-koblenz.de ([141.26.64.1]:50656 "EHLO
	mailhost.uni-koblenz.de") by vger.kernel.org with ESMTP
	id <S265671AbSIRGqL>; Wed, 18 Sep 2002 02:46:11 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rainer Krienke <krienke@uni-koblenz.de>
Organization: Uni Koblenz
To: linux-kernel@vger.kernel.org
Subject: 2.4.18: Re-read table failed with error 16: Device or resource busy - error
Date: Wed, 18 Sep 2002 08:51:10 +0200
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209180851.10297.krienke@uni-koblenz.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

I am Ruinning a (SuSE patched) 2.4.18 kernel and encountered the fdisk 
repartition problem mentioned above. I know that I could solve the problem by 
rebooting but I am interested if this is really needed since in my case a 
data recovery job was finally killed after 12 hours because there was not 
enough RAM or SWAP. I saw already very early that there could be a problem 
with swap and there was enough unpartitioned disk space to add swap, but the 
kernel would not let me. 

What I did was to add a partition on a disk that has other mounted (e.g. root) 
partitions on it. I did not change the numbering or positions of any of the 
partitions in use.The new partition was simply added after all existing 
partitions.
 
So the question is why does the kernel deny to reread the partiton table and 
force me to reboot instaed of simply doing the reread? Are there any good 
reasons for this "bad" behaviour?

Thanks
Rainer
- -- 
- ---------------------------------------------------------------------------
Rainer Krienke, Universitaet Koblenz, Rechenzentrum
Universitaetsstrasse 1, 56070 Koblenz, Tel: +49 261287 -1312, Fax: -1001312
Mail: krienke@uni-koblenz.de, Web: http://www.uni-koblenz.de/~krienke
Get my public PGP key: http://www.uni-koblenz.de/~krienke/mypgp.html
- ---------------------------------------------------------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9iCJealdtjc/KDEoRAii2AKDDEW2YUuGlqx3ZWPIElmoHBQh7kwCfYKnE
y8TYZIHmPozemlq6Y5B2mtE=
=cAEO
-----END PGP SIGNATURE-----

