Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262465AbRE0Vvx>; Sun, 27 May 2001 17:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262458AbRE0Vvn>; Sun, 27 May 2001 17:51:43 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:36052 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S262465AbRE0Vvg>;
	Sun, 27 May 2001 17:51:36 -0400
Message-ID: <3B1176DD.708C7966@mandrakesoft.com>
Date: Sun, 27 May 2001 17:51:25 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jcwren@jcwren.com, linux-kernel@vger.kernel.org
Subject: Re: Problems with ac12 kernels and up
In-Reply-To: <E1544Cy-00027I-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > Checking root filesystem. /dev/hde13 is mounted.
> > Cannot continue, aboorting.
> > *** An error occurred during the file system check.
> > *** Dropping you to a shell; the system will reboot
> > *** when you leave the shell.
> 
> That means the file system was mounted read/write at boot time. That normally
> indicates a lilo misconfiguration however your lilo.conf looks
> correct.

On 'ac' kernels at MDK, only when initrd is used, we are seeing the root
filesystem mounted read-write, no matter what rdev and bootloader
settings are...  Things are fine with no initrd.

I looked at the root_mountflags usage and it looks ok, so I put it in
the "figure out later" pile.

Haven't yet verified if this 'ac' only problem....

-- 
Jeff Garzik      | Disbelief, that's why you fail.
Building 1024    |
MandrakeSoft     |
