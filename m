Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129700AbQLHJiV>; Fri, 8 Dec 2000 04:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130127AbQLHJiN>; Fri, 8 Dec 2000 04:38:13 -0500
Received: from cerebus-ext.cygnus.co.uk ([194.130.39.252]:25336 "EHLO
	passion.cygnus") by vger.kernel.org with ESMTP id <S129700AbQLHJiC>;
	Fri, 8 Dec 2000 04:38:02 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <90p9kf$5p3$1@penguin.transmeta.com> 
In-Reply-To: <90p9kf$5p3$1@penguin.transmeta.com>  <3A30125D.5F71110D@cheek.com> 
To: torvalds@transmeta.com (Linus Torvalds)
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at buffer.c:827 in test12-pre6 and 7 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 08 Dec 2000 09:07:31 +0000
Message-ID: <18239.976266451@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


torvalds@transmeta.com said:
>  Can you test some more? In particular, I'd love to hear if this
> happens with vfat even without loopback, or with loopback even without
> vfat (make an ext2 filesystem or similar instead). That woul dnarrow
> down the bug further. 

Loopback-mounted iso9660 does it too. This was #3 on my list of test12-pre5 
oospen to investigate this weekend :)

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
