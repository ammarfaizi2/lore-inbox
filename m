Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129457AbQKLAOx>; Sat, 11 Nov 2000 19:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129460AbQKLAOn>; Sat, 11 Nov 2000 19:14:43 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:33545 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129457AbQKLAOc>;
	Sat, 11 Nov 2000 19:14:32 -0500
Message-ID: <3A0DE0C8.C700F33D@mandrakesoft.com>
Date: Sat, 11 Nov 2000 19:14:00 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: sendfile(2) fails for devices?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sendfile(2) fails with -EINVAL every time I try to read from a device
file.

This sounds like a bug... is it?  (the man page doesn't mention such a
restriction)

I am using kernel 2.4.0-test11-pre2.  All other tests with sendfile(2)
succeed:  file->file, file->STDOUT, STDIN->file...

-- 
Jeff Garzik             |
Building 1024           | Would you like a Twinkie?
MandrakeSoft            |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
