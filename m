Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289654AbSAOU0m>; Tue, 15 Jan 2002 15:26:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289643AbSAOU0Z>; Tue, 15 Jan 2002 15:26:25 -0500
Received: from 64-30-107-48.ftth.sac.winfirst.net ([64.30.107.48]:58630 "EHLO
	leng.internal") by vger.kernel.org with ESMTP id <S289652AbSAOUZv>;
	Tue, 15 Jan 2002 15:25:51 -0500
Message-ID: <0bf101c19e03$8a32cc80$7e93a8c0@sac.unify.com>
From: "Manuel McLure" <manuel@mclure.org>
To: <root@chaos.analogic.com>
Cc: "Linux Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.95.1020115143729.1338A-100000@chaos.analogic.com>
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery -- the elegant solution)
Date: Tue, 15 Jan 2002 12:30:57 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: "Richard B. Johnson" <root@chaos.analogic.com>
To: "Marco Colombo" <marco@esi.it>
Cc: "Linux Mailing List" <linux-kernel@vger.kernel.org>
Sent: Tuesday, January 15, 2002 12:13 PM
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery --
the elegant solution)


[SNIP]
> The usr/src/linux/.config was the .config obtained off from Linus`
> tree, not something provided by RedHat so `make oldconfig` would have
> made a "standard kernel" like you download from ftp.kernel.org.
>
> Now, looking in /usr/src/redhat/../.., I find some patches that are
> impossible to use to patch the kernel to bring it up (or down) to
> the configuration used to build the distribution. The default
> configuration, before I "installed" the kernel sources was some
> empty directories of /usr/src/redhat/BUILD, /usr/src/redhat/RPMS,
> /usr/src/redhat/SOURCES, /usr/src/redhat/SPECS, and /usr/src/redhat/SRPMS.
> Now there were some patches and other files with no scripts and no
> way to actually use them to modify the kernel. I spent hours, putting
> them in order, based upon the time/date stamp within the files, not
> the file time which was something more or less random. I made a script
> and tried, over a period of weeks, to patch the supplied kernel with
> the supplied patches. Forget it. If anything in this universe is truly
> impossible, then making a Red Hat distribution kernel from the provided
> tools, patches, and sources is a definitive example.
>
> Then, to add insult to injury, the 'C' compiler provided would
> not create a bootable kernel. It was egcs-2.91.66. To make
> a bootable kernel, I had to install gcc-2.96. The list goes on.

Use the RPM - all of the instructions on what patches go in what order are
in the spec file. Or, you can simply copy the appropriate configuration file
from /usr/src/redhat/SOURCES to /usr/src/linux/.config, and do a "make
oldconfig; make dep; make clean; make install; make modules; make
modules_install". Voila, new kernel. Don't tell me this doesn't work because
I've done it myself.

--
Manuel A. McLure KE6TAW | ...for in Ulthar, according to an ancient
<manuel@mclure.org>     | and significant law, no man may kill a cat.
<http://www.mclure.org> |             -- H.P. Lovecraft



