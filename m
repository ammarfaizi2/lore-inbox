Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286311AbRLTSQ7>; Thu, 20 Dec 2001 13:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286315AbRLTSQj>; Thu, 20 Dec 2001 13:16:39 -0500
Received: from nick.dcs.qmul.ac.uk ([138.37.88.61]:44422 "EHLO
	nick.dcs.qmul.ac.uk") by vger.kernel.org with ESMTP
	id <S286314AbRLTSQZ>; Thu, 20 Dec 2001 13:16:25 -0500
Date: Thu, 20 Dec 2001 18:16:24 +0000 (GMT)
From: Matt Bernstein <matt@theBachChoir.org.uk>
To: Steven Cole <scole@lanl.gov>
cc: esr@thyrsus.com, <linux-kernel@vger.kernel.org>
Subject: Re: Changing KB, MB, and GB to KiB, MiB, and GiB in Configure.help.
In-Reply-To: <200112201721.KAA05522@tstac.esa.lanl.gov>
Message-ID: <Pine.LNX.4.43.0112201810340.16545-100000@nick.dcs.qmul.ac.uk>
X-URL: http://www.theBachChoir.org.uk/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I believe that the main purpose of documentation, help etc is to get the
information across in a way that is most easily understood, ie that
minimises the number of support questions.. ..and everyone surely knows
what GB, MB and KB stand for. So let's leave it at that. Where's the "i"
in "megabyte" ? Or is 1MiB 1000000 bytes, rather than 1048576?

It's confusing enough with the 10 "Mb" networking / 1.44 "MB" floppy
distinction already..

At 11:02 -0700 Steven Cole wrote:

>Now, granted that this is the "standard", should there be some discussion related to this
>change, or is everyone comfortable with this?  It certainly made me do a double take.
>
>Here is a snippet from the diff between versions 2.75 and 2.76 of Configure.help:
>
>@@ -344,8 +344,8 @@
>   If you are compiling a kernel which will never run on a machine with
>   more than 960 megabytes of total physical RAM, answer "off" here
>   (default choice and suitable for most users). This will result in a
>-  "3GB/1GB" split: 3GB are mapped so that each process sees a 3GB
>-  virtual memory space and the remaining part of the 4GB virtual memory
>+  "3GiB/1GiB" split: 3GiB are mapped so that each process sees a 3GiB
>+  virtual memory space and the remaining part of the 4GiB virtual memory
>   space is used by the kernel to permanently map as much physical memory
>   as possible.

