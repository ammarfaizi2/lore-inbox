Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268898AbTBSNun>; Wed, 19 Feb 2003 08:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268900AbTBSNun>; Wed, 19 Feb 2003 08:50:43 -0500
Received: from host-212-9-162-143.dial.netic.de ([212.9.162.143]:38274 "EHLO
	solfire") by vger.kernel.org with ESMTP id <S268898AbTBSNul>;
	Wed, 19 Feb 2003 08:50:41 -0500
Date: Wed, 19 Feb 2003 15:01:16 +0100 (MET)
Message-Id: <20030219.150116.108734293.mccramer@s.netic.de>
To: alexander.riesen@synopsys.COM
Cc: linux-kernel@vger.kernel.org
From: Meino Christian Cramer <mccramer@s.netic.de>
In-Reply-To: <20030219123138.GQ5239@riesen-pc.gr05.synopsys.com>
References: <200302191052.47663.baldrick@wanadoo.fr>
	<20030219.131909.59461826.mccramer@s.netic.de>
	<20030219123138.GQ5239@riesen-pc.gr05.synopsys.com>
X-Mailer: Mew version 3.1 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Subject: Re: 2.5.62 fails to boot, Uncompressing... and then nothing
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Riesen <alexander.riesen@synopsys.COM>
Subject: Re: 2.5.62 fails to boot, Uncompressing... and then nothing
Date: Wed, 19 Feb 2003 13:31:38 +0100
Message-ID: <20030219123138.GQ5239@riesen-pc.gr05.synopsys.com>

Hi Alexander !

 The settings are as follows:
 /usr/src/.
 drwxr-xr-x    8 root     root          296 Feb 18 20:22 .
 drwxr-sr-x   32 root     root         1176 Jan 10 07:21 ..

 /usr/src/linux-2.5.62/.
 drwxr-xr-x    3 root     root           72 Feb 16 18:01 .
 drwxr-xr-x    8 root     root          296 Feb 18 20:22 ..

 /usr/src/ksetup/.    (this is were I kept my "alternate configurations")
 drwxr-xr-x    2 root     root         3488 Feb 19 12:59 .
 drwxr-xr-x    8 root     root          296 Feb 18 20:22 ..

 But everything works fine if
 /usr/src/ksetup/.    
 drwxrwxrwx    2 root     root         3488 Feb 19 12:59 .
 drwxr-xr-x    8 root     root          296 Feb 18 20:22 ..

 Everythings happens on the same filesystem.

 And "I am":
 uid=0(root) gid=0(root) groups=0(root)

  Hopefully this helps!
  Keep hacking!
   Meino

alexander.riesen> Meino Christian Cramer, Wed, Feb 19, 2003 13:19:09 +0100:
alexander.riesen> >  Another thing is that make menuconfig fails to write back
alexander.riesen> >  configurations as alternate files into directories owned by root
alexander.riesen> >  and set drwxr-xr-x....but it is able to write into the . directory,
alexander.riesen> >  even if it is set with drwxr-xr-x also...
alexander.riesen> 
alexander.riesen> is the "." also owned by root?
alexander.riesen> 
alexander.riesen> -
alexander.riesen> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
alexander.riesen> the body of a message to majordomo@vger.kernel.org
alexander.riesen> More majordomo info at  http://vger.kernel.org/majordomo-info.html
alexander.riesen> Please read the FAQ at  http://www.tux.org/lkml/
alexander.riesen> 
