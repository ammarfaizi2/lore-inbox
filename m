Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263057AbREWMDl>; Wed, 23 May 2001 08:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263059AbREWMDb>; Wed, 23 May 2001 08:03:31 -0400
Received: from [194.77.232.254] ([194.77.232.254]:61708 "EHLO
	hugo10.ka.punkt.de") by vger.kernel.org with ESMTP
	id <S263057AbREWMD1>; Wed, 23 May 2001 08:03:27 -0400
Date: Wed, 23 May 2001 14:03:56 +0200
From: Patric Mrawek <mrawek@punkt.de>
To: linux-kernel@vger.kernel.org
Subject: Boot Problem
Message-ID: <20010523140356.A38056@punkt.de>
Reply-To: Patric Mrawek <mrawek@punkt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: WEB Internet Services Systemhaus GmbH
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

sometimes one of my servers doesn't boot correctly. Lilo reads the
kernel-image, but doesn't decompress it. So the system won't
continue booting.

Looks like:
Loading linux...................
(at this point the machine freezes)

To be clear, most times it boots perfectly, but in 2 of 10 times it
hangs.
I tried different versions of Lilo (21.4.4-13 and 21.7-5) without success.

The system is running Redhat 7.1 with the SGI XFS patches applied and
the kernel is compressed with bzip.

[root@webtrends /root]# uname -a
Linux webtrends 2.4.2-SGI_XFS_1.0 #8 SMP Die Mai 22 10:27:24
CEST 2001 i686 unknown

The Hardware is: Tyan Thunder LE 2510UANG, 2*PIII-933, 1GB of Ram,
Mylex AccelRAID 352 configured for RAID 5

Someone can give me a hint?

Regards,
Patric
--
Patric Mrawek, Networks & Security            fon : +49 721 9109 0
WEB Internet Services Systemhaus GmbH         fax : +49 721 9109 100
D-76135 Karlsruhe, Scheffelstr. 17a           http://www.punkt.de
