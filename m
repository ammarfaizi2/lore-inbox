Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129688AbQKGN3S>; Tue, 7 Nov 2000 08:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129121AbQKGN3J>; Tue, 7 Nov 2000 08:29:09 -0500
Received: from chaos.analogic.com ([204.178.40.224]:35844 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129688AbQKGN2w>; Tue, 7 Nov 2000 08:28:52 -0500
Date: Tue, 7 Nov 2000 08:28:14 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Keith Owens <kaos@ocs.com.au>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: linux 2.4.0-test9 
In-Reply-To: <9703.973566914@ocs3.ocs-net>
Message-ID: <Pine.LNX.3.95.1001107082650.13989A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2000, Keith Owens wrote:

> On Mon, 6 Nov 2000 16:31:23 -0500 (EST), 
> "Richard B. Johnson" <root@chaos.analogic.com> wrote:
> >However when running, the new kernel 2.4.0-test9, can't be used to
> >make a usable initrd ram disk. The result being that 2.4.0-test9
> >can't, itself, build an "initrd" bootable system.
> >
> >Before everybody screams that I don't know what I'm doing, let me
> >assure you that I know that the two kernels put their modules in
> >different directories and the new directory scheme seems to require
> >the latest and greatest version of modutils.
> 
> You also need the latest version of mkinitrd to handle the modules
> directory structure.
> 
No. I have my own script(s) that have been appropriately modified
for both test floppies and boot from the hard disk.

I have found the problem. A patch will follow after I get some
breakfast. It's an obviously-correct one too.



Cheers,
Dick Johnson

Penguin : Linux version 2.2.17 on an i686 machine (801.18 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
