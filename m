Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130470AbRCHOZB>; Thu, 8 Mar 2001 09:25:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130096AbRCHOYv>; Thu, 8 Mar 2001 09:24:51 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:31500 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130051AbRCHOYo>; Thu, 8 Mar 2001 09:24:44 -0500
Subject: Re: 2.4.2 kernel mount crash
To: remco@solbors.no (Remco B. Brink)
Date: Thu, 8 Mar 2001 14:27:02 +0000 (GMT)
Cc: jiezhou@us.ibm.com (Jie Zhou), linux-kernel@vger.kernel.org
In-Reply-To: <m3itlkuz5d.fsf@localhost.localdomain> from "Remco B. Brink" at Mar 08, 2001 03:13:34 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14b1Nh-000321-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > During the "make bzImage"step, I got bunch of this warning:
> > "pasting would not give a valid preprocessing token". then I just ignored

The pasting warning is harmless

> The above message is related to the version of gcc that you get with
> your copy of RedHat7. You might just want to use kgcc instead of gcc
> to compile your kernel.

kgcc or gcc 2.96-69  (2.96-74 for DAC960 due to a structure packing assumption
in DAC960)

> I used kgcc to compile the kernel, did not get any of the RH7 gcc warning messages
> and still am left with a not-so-stable mount.

Its certainly worth building with kgcc as well to make sure, and in this case
it looks like the problem is really in the kernel proper

