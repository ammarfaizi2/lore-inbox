Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129130AbQKDKz5>; Sat, 4 Nov 2000 05:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129449AbQKDKzr>; Sat, 4 Nov 2000 05:55:47 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:26640 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129130AbQKDKze>;
	Sat, 4 Nov 2000 05:55:34 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: root@chaos.analogic.com
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.4.0-test9 
In-Reply-To: Your message of "Fri, 03 Nov 2000 17:54:51 CDT."
             <Pine.LNX.3.95.1001103175055.612A-100000@chaos.analogic.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 04 Nov 2000 21:55:27 +1100
Message-ID: <6695.973335327@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Nov 2000 17:54:51 -0500 (EST), 
"Richard B. Johnson" <root@chaos.analogic.com> wrote:
>(1)	I have SCSI modules that have to be installed upon boot
>from initrd. Insmod failed with "Can't find the kernel version that
>this module was compiled with..."

"Can't find the kernel version that this module was compiled with..."
means that the module object does not contain symbol __module_kernel_version.
What does 'nm' on the module report?

>modutils, downloaded and installed today. Also `insmod -f` doesn't
>work (not a kernel problem, yes, I know).

Does not work how?  Details please.

>The only fix I could come up with was to remove EXTRAVERSION=test9 in
>the top-level Makefile (actually set it to nothing), then recompile
>the whole kernel. This problem will get others, I am sure.

I suspect user error, probably old modules lying around somewhere.  A
compile out of the box for 2.4.0-test9 worked fine for me and AFAICT
for everybody else.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
