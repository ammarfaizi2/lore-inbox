Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130149AbQK2XKk>; Wed, 29 Nov 2000 18:10:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130405AbQK2XKa>; Wed, 29 Nov 2000 18:10:30 -0500
Received: from mail2.uni-bielefeld.de ([129.70.4.90]:12121 "EHLO
        mail.uni-bielefeld.de") by vger.kernel.org with ESMTP
        id <S130149AbQK2XKV>; Wed, 29 Nov 2000 18:10:21 -0500
Date: Wed, 29 Nov 2000 22:36:12 +0000
From: Marc Mutz <Marc@Mutz.com>
Subject: Re: 'holey files' not holey enough.
To: Adam <adam@cfar.umd.edu>
Cc: linux-kernel@vger.kernel.org
Message-id: <3A2584DC.1699B6CD@Mutz.com>
Organization: University of Bielefeld - Dep. of Mathematics / Dep. of Physics
MIME-version: 1.0
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17i10-0001 i586)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
X-Accept-Language: en
In-Reply-To: <Pine.GSO.4.21.0011290755570.2862-100000@chia.umiacs.umd.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel 2.2.17, '/' being a 1k blocksize ext2fs:

root@adam:/ > dd if=/dev/zero of=holed.file bs=1000 seek=5000 count=1000
1000+0 records in
1000+0 records out
root@adam:/ > ls -l holed.file
-rw-r--r--   1 root     root      6000000 Nov 29 23:33 holed.file
root@adam:/ > du -sh holed.file
5.7M    holed.file

Now that seems funny.

Marc

-- 
Marc Mutz <Marc@Mutz.com>     http://EncryptionHOWTO.sourceforge.net/
University of Bielefeld, Dep. of Mathematics / Dep. of Physics

PGP-keyID's:   0xd46ce9ab (RSA), 0x7ae55b9e (DSS/DH)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
