Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130230AbQKXXJ2>; Fri, 24 Nov 2000 18:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130255AbQKXXJS>; Fri, 24 Nov 2000 18:09:18 -0500
Received: from ruddock-207.caltech.edu ([131.215.90.207]:21522 "EHLO
        agard.caltech.edu") by vger.kernel.org with ESMTP
        id <S130230AbQKXXJE>; Fri, 24 Nov 2000 18:09:04 -0500
Message-ID: <3A1EEFC8.16A48C24@its.caltech.edu>
Date: Fri, 24 Nov 2000 14:46:32 -0800
From: James Lamanna <jlamanna@its.caltech.edu>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Fasttrak100 questions...
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So, I have a system that has 2 45GB IDE drives connected
up to a Promise Technologies Fasttrack 100.
Promise Techonologies currently has a driver that you can compile
against a 2.2 kernel into a module, but it also includes one
proprietary object file.
During my linux installation I was able to preload the module and
have it detect the drives fine as a scsi device, so I was able to
install the base system onto them.
 
The question is, is there a way to compile this module into the kernel
so that it will automatically detect the card? A simple linking of the
module into the scsi library by editing the Makefile doesn't seem to do
it. It doesn't detect the drives if I boot off of a floppy with this
kernel on it.

Also, is it possible for Lilo to even boot this without a RAM disk
somewhere? I guess Lilo has to know about the drive, but it can't know
without the module...so am I screwed into using floppies with a
RAM disk image anyways?

Thanks,
--James Lamanna
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
