Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316437AbSHDMhd>; Sun, 4 Aug 2002 08:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316532AbSHDMhc>; Sun, 4 Aug 2002 08:37:32 -0400
Received: from pop.gmx.net ([213.165.64.20]:14260 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S316437AbSHDMhb>;
	Sun, 4 Aug 2002 08:37:31 -0400
Date: Sun, 4 Aug 2002 14:41:07 +0200
From: Marc Giger <gigerstyle@gmx.ch>
To: linux-kernel@vger.kernel.org
Subject: Booting 2.4.19xx with initrd
Message-Id: <20020804144107.26b1b330.gigerstyle@gmx.ch>
X-Mailer: Sylpheed version 0.7.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Now I can finally boot any 2.4.19 kernels *yippie:-)

I found the reason why it did not work before:

Normally, I am always making an initial ramdisk for better portability to other computers. The initird is causing problems with these kernels. 
When Lilo has loaded the initrd it prints out that it can't mount root fs on 302 or 03:02.....
Booting without an initrd is running smoothly. 
There are no such problems with older kernels like 2.4.18 and earlier.

Well... is there any solution?

Some additional info:

Sony Vaio GR114EK
with i8xxx chipset
and Hitachi IDE HD

same problem on:

Sony Vaio PCG-F707
with intel 440BX chipset
and a IBM IDE HD

On both laptops the root and the boot fs are on the same partition.

Thanks guys!

Marc Giger
