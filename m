Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129657AbQLCHEf>; Sun, 3 Dec 2000 02:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129811AbQLCHE0>; Sun, 3 Dec 2000 02:04:26 -0500
Received: from smtp01.mrf.mail.rcn.net ([207.172.4.60]:20888 "EHLO
	smtp01.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S129657AbQLCHEO>; Sun, 3 Dec 2000 02:04:14 -0500
Message-ID: <3A29E92F.119BC47B@haque.net>
Date: Sun, 03 Dec 2000 01:33:19 -0500
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Saber Taylor <aquabrake@hotmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: lost dirs after fsck-1.18 (kt133, ide, dma, test10, test11)
In-Reply-To: <F231OceuLyR1mDxJr5D0000c3f6@hotmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You saying that you were running test kernels on a production box and
seriously didn't expect something bad to happen?

Filesystem corruptions arent things you can recover files from. You're
confusing accidentally deleting files and undeleting them later.

What would be useful is if you noted where/why you ran 'fsck -y'. Did
you crash and fs check at boot failed? What?

Saber Taylor wrote:
> 
> Well that's the last time I run a devel kernel with a nontest
> system.  sigh.
> 
> Had one directory replaced with a different directory
> and also a directory replaced with a file. Possible further
> corruption.
> 
> I don't think I lost the directories until I did a 'fsck -y'
> on the partition. Something to remember.
> 
> If anyone has advice on recovering the directories other than
> the following links, I'm all ears:
> 
> http://www.datafoundation.org/lde/
> http://www.linuxdoc.org/HOWTO/mini/Ext2fs-Undeletion.html
> (last updated February 1999)
> http://www.linuxdoc.org/HOWTO/mini/Ext2fs-Undeletion-Dir-Struct/
> 
> Saber Taylor

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
