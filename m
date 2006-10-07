Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422878AbWJGCAk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422878AbWJGCAk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 22:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422886AbWJGCAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 22:00:40 -0400
Received: from xenotime.net ([66.160.160.81]:38075 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1422878AbWJGCAj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 22:00:39 -0400
Date: Fri, 6 Oct 2006 19:02:04 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Matt LaPlante <kernel1@cyberdogtech.com>
Cc: linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH 19-rc1]  Fix typos in /Documentation : 'U-Z'
Message-Id: <20061006190204.9ccacbeb.rdunlap@xenotime.net>
In-Reply-To: <20061006095031.7dfcbe53.kernel1@cyberdogtech.com>
References: <20061006095031.7dfcbe53.kernel1@cyberdogtech.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Oct 2006 09:50:31 -0400 Matt LaPlante wrote:

> This patch fixes typos in various Documentation txts. The patch addresses some words starting with the letters 'U-Z'.  

Mostly good, but I have a few comments below.

> diff -ru a/Documentation/block/biodoc.txt b/Documentation/block/biodoc.txt
> --- a/Documentation/block/biodoc.txt	2006-10-05 22:18:50.000000000 -0400
> +++ b/Documentation/block/biodoc.txt	2006-10-05 23:04:59.000000000 -0400
> @@ -403,14 +403,14 @@
>      for raw i/o.
>  ii. Ability to represent high-memory buffers (which do not have a virtual
>      address mapping in kernel address space).
> -iii.Ability to represent large i/os w/o unecessarily breaking them up (i.e
> +iii.Ability to represent large i/os w/o unnecessarily breaking them up (i.e

I'd prefer to see "I/Os"  "without"   "i.e.".

> diff -ru a/Documentation/filesystems/spufs.txt b/Documentation/filesystems/spufs.txt
> --- a/Documentation/filesystems/spufs.txt	2006-10-05 22:18:51.000000000 -0400
> +++ b/Documentation/filesystems/spufs.txt	2006-10-05 22:53:50.000000000 -0400
> @@ -210,7 +210,7 @@
>     /signal2
>         The two signal notification channels of an SPU.  These  are  read-write
>         files  that  operate  on  a 32 bit word.  Writing to one of these files
> -       triggers an interrupt on the SPU. The  value  writting  to  the  signal
> +       triggers an interrupt on the SPU.  The  value  writing  to  the  signal

I think that should be "written".

>         files can be read from the SPU through a channel read or from host user
>         space through the file.  After the value has been read by the  SPU,  it
>         is  reset  to zero.  The possible operations on an open signal1 or sig-

> diff -ru a/Documentation/MSI-HOWTO.txt b/Documentation/MSI-HOWTO.txt
> --- a/Documentation/MSI-HOWTO.txt	2006-10-05 22:18:52.000000000 -0400
> +++ b/Documentation/MSI-HOWTO.txt	2006-10-05 22:31:22.000000000 -0400
> @@ -219,7 +219,7 @@
>  Note that the pre-assigned IOAPIC dev->irq is valid only if the device
>  operates in PIN-IRQ assertion mode. In MSI-X mode, any attempt at
>  using dev->irq by the device driver to request for interrupt service
> -may result unpredictabe behavior.
> +may result unpredictable behavior.

   may result in unpredictable behavior.

>  For each MSI-X vector granted, a device driver is responsible for calling
>  other functions like request_irq(), enable_irq(), etc. to enable

---
~Randy
