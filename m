Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317171AbSHBUsa>; Fri, 2 Aug 2002 16:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317211AbSHBUsa>; Fri, 2 Aug 2002 16:48:30 -0400
Received: from khms.westfalen.de ([62.153.201.243]:6097 "EHLO
	khms.westfalen.de") by vger.kernel.org with ESMTP
	id <S317171AbSHBUs2>; Fri, 2 Aug 2002 16:48:28 -0400
Date: 02 Aug 2002 20:33:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8U6Y4oS1w-B@khms.westfalen.de>
In-Reply-To: <200208021454.JAA37529@tomcat.admin.navo.hpc.mil>
Subject: Re: 2.5.28 and partitions
X-Mailer: CrossPoint v3.12d.kh9 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
References: <200208021454.JAA37529@tomcat.admin.navo.hpc.mil>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pollard@tomcat.admin.navo.hpc.mil (Jesse Pollard)  wrote on 02.08.02 in <200208021454.JAA37529@tomcat.admin.navo.hpc.mil>:

> kaih@khms.westfalen.de (Kai Henningsen):
> ...
> > As for finding where to boot from - either have the bootloader define a
> > partition name it wants to see, or put the relevant name into the boot
> > loader config. No need to define that in the partition format. That's
> > trivial: even MS-DOS did that (finding IO.SYS and MSDOS.SYS from the boot
> > loader)! And neither scanning for '=' and '\n' nor comparing one string
> > nor converting one number from decimal is any kind of hardship. Maybe half
> > a screen of assembler, tops.
> >
>
> Nope.
>
> The problem is different - which file system is the file stored in?

Huh?! What file?!

> How many different filesystems are there?

That's not a question for the bootloader.

> Do think all of them will fit in a boot loader?

Who cares? You can always give it a partition of its own. (The example did  
exactly that!)

> Or even one of them?
> How many different logical volume structures are there?

I have no idea what you are talking about here.

> Do do this you first have to convince the development people to say that
> "only xxxx filesystem shall be bootable".

Utter nonsense.

> And now, you also have to add possible logical volumes on top (or under :)
> of it.

What are you babbling about?

> That is why LILO doesn't use file names for boots. It only uses block
> numbers.

So?

(By the way, it's the *only* boot loader I know that does this.)

> Another alternative (possibly just as hard) is to have LILO only
> load a more complex and dynamic loader, which could be configured for
> each filesystem structure. Once that "dynamic loader" is loaded, it
> could find and load the kernel (passing, of course, the boot command line
> from LILO).

What on earth does that have to do with the format of a partition table?!

> I know IRIX gets around the problem by having a tiny filesystem for the
> "disk label". This filesystem contains only contigeous files, and has

Around *which* problem?! That's certainly something that's only relevant  
after the bootloader is long gone.

Frankly, I have no idea what you're smoking, but it can't be healthy.

MfG Kai
