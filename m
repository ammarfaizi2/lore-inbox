Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129933AbQK1UxT>; Tue, 28 Nov 2000 15:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129870AbQK1UxJ>; Tue, 28 Nov 2000 15:53:09 -0500
Received: from imap1.gromco.com ([209.10.98.67]:57355 "EHLO gromco.com")
        by vger.kernel.org with ESMTP id <S129933AbQK1Uwy>;
        Tue, 28 Nov 2000 15:52:54 -0500
Message-ID: <3A2413D8.69C18FF8@gromco.com>
Date: Tue, 28 Nov 2000 15:21:44 -0500
From: Vladislav Malyshkin <mal@gromco.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: 2.2.16-22 (RedHat 7.0) fs problem
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

when doing mount/umount of a MSDOS floppy on 2.2.16-22
I often get

/var/log/messages.1:Nov 25 21:02:18 localhost kernel: set_blocksize: dev
02:00 buffer_dirty 19 size 512
/var/log/messages.2:Nov 16 18:19:05 localhost kernel: set_blocksize: dev
02:00 buffer_dirty 19 size 512

Is this harmless or sume bug in the filesystem?

Vladislav

The system is:
processor : 0
vendor_id : GenuineIntel
cpu family : 5
model  : 2
model name : Pentium 75 - 200
stepping : 5
cpu MHz  : 90.001
fdiv_bug : no
hlt_bug  : no
sep_bug  : no
f00f_bug : yes
coma_bug : no
fpu  : yes
fpu_exception : yes
cpuid level : 1
wp  : yes
flags  : fpu vme de pse tsc msr mce cx8
bogomips : 179.40



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
