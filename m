Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265810AbRGODrO>; Sat, 14 Jul 2001 23:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265844AbRGODrE>; Sat, 14 Jul 2001 23:47:04 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:62378 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S265810AbRGODqy>;
	Sat, 14 Jul 2001 23:46:54 -0400
Message-ID: <3B511226.B48B22F1@mandrakesoft.com>
Date: Sat, 14 Jul 2001 23:46:46 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, David Woodhouse <dwmw2@infradead.org>,
        Christoph Hellwig <hch@caldera.de>,
        Gunther Mayer <Gunther.Mayer@t-online.de>, paul@paulbristow.net,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: (patch-2.4.6) Fix oops with Iomega Clik! (ide-floppy)
In-Reply-To: <E15LTIY-0001Ul-00@the-village.bc.nu> <20010715154008.B7624@weta.f00f.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> /* KERNEL_PRIVATE_BEGIN: blah */
> 
> struct internal organs(int foo, char *bar);
> 
> /* KERNEL_PRIVATE_END */

1) this is the same fscking thing we have now with ifdef __KERNEL__

2) if you are coming up with a -new- token, realize that kernel-private
stuff is the common case, and use LIBC_KERNEL_SHARED_{BEGIN,END} instead

-- 
Jeff Garzik      | A recent study has shown that too much soup
Building 1024    | can cause malaise in laboratory mice.
MandrakeSoft     |
