Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130180AbRB1OKG>; Wed, 28 Feb 2001 09:10:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130183AbRB1OJ4>; Wed, 28 Feb 2001 09:09:56 -0500
Received: from [202.123.212.187] ([202.123.212.187]:33807 "EHLO ns1.b2s.com")
	by vger.kernel.org with ESMTP id <S130180AbRB1OJu>;
	Wed, 28 Feb 2001 09:09:50 -0500
Message-ID: <3A9D06C7.6CEA9522@vtc.edu.hk>
Date: Wed, 28 Feb 2001 22:10:15 +0800
From: Nick Urbanik <nicku@vtc.edu.hk>
Organization: Institute of Vocational Education (Tsing Yi)
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kernel list <linux-kernel@vger.kernel.org>
Subject: loop hang in 2.4.2 solved in 2.4.2-ac5
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear folks,

Our server was unable to mount or umount loop devices mounting iso
images; the same problem occurred in 2.4.2-pre[34] and 2.4.2: an
absolute disaster for us; we had to reboot to another kernel just to
make initrd images to boot off SCSI, let alone make software available
to our staff and students.

Now 2.4.2-ac5 works beautifully for us.  Thank you to Jens Axboe, Andrea
Arcangeli and Al Viro.  And Alan for putting it together.

--
Nick Urbanik, Dept. of Computing and Mathematics
Hong Kong Institute of Vocational Education (Tsing Yi)
email: nicku@vtc.edu.hk
Tel:   (852) 2436 8576, (852) 2436 8579   Fax: (852) 2435 1406
pgp ID: 7529555D fingerprint: 53 B6 6D 73 52 EE 1F EE EC F8 21 98 45 1C 23 7B



