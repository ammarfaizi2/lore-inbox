Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131830AbQLHBzP>; Thu, 7 Dec 2000 20:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131845AbQLHBzF>; Thu, 7 Dec 2000 20:55:05 -0500
Received: from saltlake.cheek.com ([207.202.196.152]:17933 "EHLO
	saltlake.cheek.com") by vger.kernel.org with ESMTP
	id <S131844AbQLHByr>; Thu, 7 Dec 2000 20:54:47 -0500
Message-ID: <3A303827.AF486F37@cheek.com>
Date: Thu, 07 Dec 2000 17:23:51 -0800
From: Joseph Cheek <joseph@cheek.com>
X-Mailer: Mozilla 4.73C-CCK-MCD Caldera Systems OpenLinux [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at buffer.c:827 in test12-pre6 and 7
In-Reply-To: <3A30125D.5F71110D@cheek.com> <90p9kf$5p3$1@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i'll check it out.  i'm compiling ksymoops now, is there a way to get it to
work without a static libbfd?  all i've got is a libbfd.so, and i'm going to
need to recompile binutils if i must have a libbfd.a.

Linus Torvalds wrote:

> Your stack trace isn't symbolic (see Documentation/oops-tracing.txt), so
> it's impossible to debug, but it's already interesting information to
> see that it seems to be either loopback of vfat.
>
> Can you test some more? In particular, I'd love to hear if this happens
> with vfat even without loopback, or with loopback even without vfat
> (make an ext2 filesystem or similar instead). That woul dnarrow down the
> bug further.

thanks!

joe

--
Joseph Cheek, Sr Linux Consultant, Linuxcare | http://www.linuxcare.com/
Linuxcare.  Support for the Revolution.      | joseph@linuxcare.com
CTO / Acting PM, Redmond Linux Project       | joseph@redmondlinux.org
425 990-1072 vox [1074 fax] 206 679-6838 pcs | joseph@cheek.com



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
