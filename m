Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030759AbWJKEEj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030759AbWJKEEj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 00:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030785AbWJKEEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 00:04:39 -0400
Received: from xenotime.net ([66.160.160.81]:49096 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030759AbWJKEEi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 00:04:38 -0400
Date: Tue, 10 Oct 2006 21:06:01 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Matt LaPlante <kernel1@cyberdogtech.com>
Cc: linux-kernel@vger.kernel.org, trivial@kernel.org, device@lanana.org
Subject: Re: [PATCH 19-rc1]  Fix typos in /Documentation : Misc
Message-Id: <20061010210601.f693fafd.rdunlap@xenotime.net>
In-Reply-To: <20061010211938.3f53262c.kernel1@cyberdogtech.com>
References: <20061010211938.3f53262c.kernel1@cyberdogtech.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2006 21:19:38 -0400 Matt LaPlante wrote:

> This patch fixes typos in various Documentation txts. The patch addresses some misc words.  

Lots of good stuff.  Plus a few comments below.

> diff -ru a/Documentation/devices.txt b/Documentation/devices.txt
> --- a/Documentation/devices.txt	2006-10-06 21:28:14.000000000 -0400
> +++ b/Documentation/devices.txt	2006-10-06 22:30:10.000000000 -0400

These all look good, but we need to make sure that the LANANA
people get this patch too.  (cc-ed)

I think that there was another devices.txt patch in the last
couple of weeks.  Is anybody collecting those??

> @@ -92,7 +92,7 @@
>  		  7 = /dev/full		Returns ENOSPC on write
>  		  8 = /dev/random	Nondeterministic random number gen.
>  		  9 = /dev/urandom	Faster, less secure random number gen.
> -		 10 = /dev/aio		Asyncronous I/O notification interface
> +		 10 = /dev/aio		Asynchronous I/O notification interface
>  		 11 = /dev/kmsg		Writes to this come out as printk's
>    1 block	RAM disk
>  		  0 = /dev/ram0		First RAM disk
> @@ -1093,7 +1093,7 @@
>  
>   55 char	DSP56001 digital signal processor
>  		  0 = /dev/dsp56k	First DSP56001
> - 55 block	Mylex DAC960 PCI RAID controller; eigth controller
> + 55 block	Mylex DAC960 PCI RAID controller; eighth controller
>  		  0 = /dev/rd/c7d0	First disk, whole disk
>  		  8 = /dev/rd/c7d1	Second disk, whole disk
>  		    ...
> @@ -1456,7 +1456,7 @@
>  		  1 = /dev/cum1		Callout device for ttyM1
>  		    ...
>  
> - 79 block	Compaq Intelligent Drive Array, eigth controller
> + 79 block	Compaq Intelligent Drive Array, eighth controller
>  		  0 = /dev/ida/c7d0	First logical drive whole disk
>  		 16 = /dev/ida/c7d1	Second logical drive whole disk
>  		    ...
> @@ -1900,7 +1900,7 @@
>  		  1 = /dev/av1		Second A/V card
>  		    ...
>  
> -111 block	Compaq Next Generation Drive Array, eigth controller
> +111 block	Compaq Next Generation Drive Array, eighth controller
>  		  0 = /dev/cciss/c7d0	First logical drive, whole disk
>  		 16 = /dev/cciss/c7d1	Second logical drive, whole disk
>  		    ...

> diff -ru a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
> --- a/Documentation/powerpc/booting-without-of.txt	2006-10-06 21:28:15.000000000 -0400
> +++ b/Documentation/powerpc/booting-without-of.txt	2006-10-06 22:12:06.000000000 -0400

> @@ -854,7 +854,7 @@
>        console device if any. Typically, if you have serial devices on
>        your board, you may want to put the full path to the one set as
>        the default console in the firmware here, for the kernel to pick
> -      it up as it's own default console. If you look at the funciton
> +      it up as it's own default console. If you look at the function

                  its

>        set_preferred_console() in arch/ppc64/kernel/setup.c, you'll see
>        that the kernel tries to find out the default console and has
>        knowledge of various types like 8250 serial ports. You may want

> diff -ru a/Documentation/s390/Debugging390.txt b/Documentation/s390/Debugging390.txt
> --- a/Documentation/s390/Debugging390.txt	2006-10-06 21:44:21.000000000 -0400
> +++ b/Documentation/s390/Debugging390.txt	2006-10-06 21:44:28.000000000 -0400

> @@ -1037,12 +1037,12 @@
>  
>  Performance Debugging
>  =====================
> -gcc is capible of compiling in profiling code just add the -p option
> -to the CFLAGS, this obviously affects program size & performance.
> +gcc is capable of compiling in profiling code; just add the -p option
> +to the CFLAGS (this obviously affects program size & performance).
>  This can be used by the gprof gnu profiling tool or the
> -gcov the gnu code coverage tool ( code coverage is a means of testing
> +gcov the gnu code coverage tool (code coverage is a means of testing

   gcov gnu code coverage tool...

>  code quality by checking if all the code in an executable in exercised by
> -a tester ).
> +a tester).

> diff -ru a/Documentation/sysctl/vm.txt b/Documentation/sysctl/vm.txt
> --- a/Documentation/sysctl/vm.txt	2006-10-06 21:44:21.000000000 -0400
> +++ b/Documentation/sysctl/vm.txt	2006-10-06 21:44:28.000000000 -0400
> @@ -129,7 +129,7 @@
>  
>  zone_reclaim_mode:
>  
> -Zone_reclaim_mode allows to set more or less agressive approaches to
> +Zone_reclaim_mode allows to set more or less aggressive approaches to

                     allows someone (or "one")

>  reclaim memory when a zone runs out of memory. If it is set to zero then no
>  zone reclaim occurs. Allocations will be satisfied from other zones / nodes
>  in the system.

and Thanks.

---
~Randy
