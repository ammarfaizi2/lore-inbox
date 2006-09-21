Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751665AbWIUWGe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751665AbWIUWGe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 18:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751667AbWIUWGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 18:06:33 -0400
Received: from xenotime.net ([66.160.160.81]:56032 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751661AbWIUWGd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 18:06:33 -0400
Date: Thu, 21 Sep 2006 15:07:38 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Michael Opdenacker <michael-lists@free-electrons.com>
Cc: linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH 2.6.18] [TRIVIAL] Spelling fixes in
 Documentation/DocBook
Message-Id: <20060921150738.ed407645.rdunlap@xenotime.net>
In-Reply-To: <200609212318.07418.michael-lists@free-electrons.com>
References: <200609212318.07418.michael-lists@free-electrons.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2006 23:18:06 +0200 Michael Opdenacker wrote:

> Hello,

> diff -Nurp linux-2.6.18/Documentation/DocBook/gadget.tmpl 
> linux-2.6.18-aspell-docbook/Documentation/DocBook/gadget.tmpl
> --- linux-2.6.18/Documentation/DocBook/gadget.tmpl	2006-09-20 
> 05:42:06.000000000 +0200
> +++ linux-2.6.18-aspell-docbook/Documentation/DocBook/gadget.tmpl	2006-09-21 
> 13:54:36.000000000 +0200
> @@ -585,11 +585,11 @@ over time, as this driver framework evol
>  for usb controller hardware), other gadget drivers exist.
>  </para>
>  
> -<para>There's an <emphasis>ethernet</emphasis> gadget
> +<para>There's an <emphasis>Ethernet</emphasis> gadget
>  driver, which implements one of the most useful
>  <emphasis>Communications Device Class</emphasis> (CDC) models.  
>  One of the standards for cable modem interoperability even
> -specifies the use of this ethernet model as one of two
> +specifies the use of this Ethernet model as one of two
>  mandatory options.
>  Gadgets using this code look to a USB host as if they're
>  an Ethernet adapter.

I used to capitalize Ethernet, but is has become a common word
IMO.  The only reason that I see to capitalize it here is for
consistency.  (see last quoted line above)

> @@ -667,7 +667,7 @@ hardware level details could be very dif
>  
>  <para>Systems need specialized hardware support to implement OTG,
>  notably including a special <emphasis>Mini-AB</emphasis> jack
> -and associated transciever to support <emphasis>Dual-Role</emphasis>
> +and associated transceiver to support <emphasis>Dual-Role</emphasis>
>  operation:
>  they can act either as a host, using the standard
>  Linux-USB host side driver stack,
> diff -Nurp linux-2.6.18/Documentation/DocBook/genericirq.tmpl 
> linux-2.6.18-aspell-docbook/Documentation/DocBook/genericirq.tmpl
> --- linux-2.6.18/Documentation/DocBook/genericirq.tmpl	2006-09-20 
> 05:42:06.000000000 +0200
> +++ linux-2.6.18-aspell-docbook/Documentation/DocBook/genericirq.tmpl	
> 2006-09-21 21:42:18.000000000 +0200

ack

> diff -Nurp linux-2.6.18/Documentation/DocBook/journal-api.tmpl 
> linux-2.6.18-aspell-docbook/Documentation/DocBook/journal-api.tmpl
> --- linux-2.6.18/Documentation/DocBook/journal-api.tmpl	2006-09-20 
> 05:42:06.000000000 +0200
> +++ linux-2.6.18-aspell-docbook/Documentation/DocBook/journal-api.tmpl	
> 2006-09-21 21:48:37.000000000 +0200
> @@ -4,7 +4,7 @@
>  
>  <book id="LinuxJBDAPI">
>   <bookinfo>
> -  <title>The Linux Journalling API</title>
> +  <title>The Linux Journaling API</title>

We've seen this one before.
UK vs. US spelling, leave it as is.  (or use a UK dictionary)

> diff -Nurp linux-2.6.18/Documentation/DocBook/kernel-hacking.tmpl 
> linux-2.6.18-aspell-docbook/Documentation/DocBook/kernel-hacking.tmpl
> --- linux-2.6.18/Documentation/DocBook/kernel-hacking.tmpl	2006-09-20 
> 05:42:06.000000000 +0200
> +++ linux-2.6.18-aspell-docbook/Documentation/DocBook/kernel-hacking.tmpl	
> 2006-09-21 22:01:17.000000000 +0200
> @@ -796,7 +796,7 @@ printk(KERN_INFO "my ip: %d.%d.%d.%d\n",
>     </para>
>  
>     <para>
> -   Most registerable structures have an
> +   Most registrable structures have an

Hm.  The first way makes sense.  :)

>     <structfield>owner</structfield> field, such as in the
>     <structname>file_operations</structname> structure. Set this field
>     to the macro <symbol>THIS_MODULE</symbol>.
> @@ -1028,7 +1028,7 @@ printk(KERN_INFO "my ip: %d.%d.%d.%d\n",
>  
>     <para>
>      The preferred method of initializing structures is to use
> -    designated initialisers, as defined by ISO C99, eg:
> +    designated initializers, as defined by ISO C99, eg:

UK spelling, it's OK.

> diff -Nurp linux-2.6.18/Documentation/DocBook/kernel-locking.tmpl 
> linux-2.6.18-aspell-docbook/Documentation/DocBook/kernel-locking.tmpl
> --- linux-2.6.18/Documentation/DocBook/kernel-locking.tmpl	2006-09-20 
> 05:42:06.000000000 +0200
> +++ linux-2.6.18-aspell-docbook/Documentation/DocBook/kernel-locking.tmpl	
> 2006-09-21 22:06:56.000000000 +0200

ack

> diff -Nurp linux-2.6.18/Documentation/DocBook/libata.tmpl 
> linux-2.6.18-aspell-docbook/Documentation/DocBook/libata.tmpl
> --- linux-2.6.18/Documentation/DocBook/libata.tmpl	2006-09-20 
> 05:42:06.000000000 +0200
> +++ linux-2.6.18-aspell-docbook/Documentation/DocBook/libata.tmpl	2006-09-21 
> 22:14:56.000000000 +0200

ack all except "iff".  That is "if and only if".

> @@ -1415,7 +1415,7 @@ and other resources, etc.
>  	<para>
>  	HBA resetting is implementation specific.  For a controller
>  	complying to taskfile/BMDMA PCI IDE, stopping active DMA
> -	transaction may be sufficient iff BMDMA state is the only HBA
> +	transaction may be sufficient if BMDMA state is the only HBA
>  	context.  But even mostly taskfile/BMDMA PCI IDE complying
>  	controllers may have implementation specific requirements and
>  	mechanism to reset themselves.  This must be addressed by

> diff -Nurp linux-2.6.18/Documentation/DocBook/librs.tmpl 
> linux-2.6.18-aspell-docbook/Documentation/DocBook/librs.tmpl
> --- linux-2.6.18/Documentation/DocBook/librs.tmpl	2006-09-20 
> 05:42:06.000000000 +0200
> +++ linux-2.6.18-aspell-docbook/Documentation/DocBook/librs.tmpl	2006-09-21 
> 22:18:07.000000000 +0200

ack

> diff -Nurp linux-2.6.18/Documentation/DocBook/mcabook.tmpl 
> linux-2.6.18-aspell-docbook/Documentation/DocBook/mcabook.tmpl
> --- linux-2.6.18/Documentation/DocBook/mcabook.tmpl	2006-09-20 
> 05:42:06.000000000 +0200
> +++ linux-2.6.18-aspell-docbook/Documentation/DocBook/mcabook.tmpl	2006-09-21 
> 22:20:18.000000000 +0200

ack

> diff -Nurp linux-2.6.18/Documentation/DocBook/mtdnand.tmpl 
> linux-2.6.18-aspell-docbook/Documentation/DocBook/mtdnand.tmpl
> --- linux-2.6.18/Documentation/DocBook/mtdnand.tmpl	2006-09-20 
> 05:42:06.000000000 +0200
> +++ linux-2.6.18-aspell-docbook/Documentation/DocBook/mtdnand.tmpl	2006-09-21 
> 22:32:00.000000000 +0200

ack all except this one:

> @@ -488,17 +488,17 @@ static void board_select_chip (struct mt
>  				Reed-Solomon library.
>  			</para>
>  			<para>
> -				The ECC bytes must be placed immidiately after the data
> +				The ECC bytes must be placed immediately after the data
>  				bytes in order to make the syndrome generator work. This
>  				is contrary to the usual layout used by software ECC. The
> -				seperation of data and out of band area is not longer
> +				separation of data and out of band area is not longer

"no longer"

>  				possible. The nand driver code handles this layout and
>  				the remaining free bytes in the oob area are managed by 
>  				the autoplacement code. Provide a matching oob-layout
>  				in this case. See rts_from4.c and diskonchip.c for 
>  				implementation reference. In those cases we must also
>  				use bad block tables on FLASH, because the ECC layout is
> -				interferring with the bad block marker positions.
> +				interfering with the bad block marker positions.
>  				See bad block table support for details.
>  			</para>
>  		</sect2>

> diff -Nurp linux-2.6.18/Documentation/DocBook/usb.tmpl 
> linux-2.6.18-aspell-docbook/Documentation/DocBook/usb.tmpl
> --- linux-2.6.18/Documentation/DocBook/usb.tmpl	2006-09-20 05:42:06.000000000 
> +0200
> +++ linux-2.6.18-aspell-docbook/Documentation/DocBook/usb.tmpl	2006-09-21 
> 22:38:21.000000000 +0200

ack

> diff -Nurp linux-2.6.18/Documentation/DocBook/videobook.tmpl 
> linux-2.6.18-aspell-docbook/Documentation/DocBook/videobook.tmpl
> --- linux-2.6.18/Documentation/DocBook/videobook.tmpl	2006-09-20 
> 05:42:06.000000000 +0200
> +++ linux-2.6.18-aspell-docbook/Documentation/DocBook/videobook.tmpl	
> 2006-09-21 22:43:14.000000000 +0200

ack

> diff -Nurp linux-2.6.18/Documentation/DocBook/writing_usb_driver.tmpl 
> linux-2.6.18-aspell-docbook/Documentation/DocBook/writing_usb_driver.tmpl
> --- linux-2.6.18/Documentation/DocBook/writing_usb_driver.tmpl	2006-09-20 
> 05:42:06.000000000 +0200
> +++ linux-2.6.18-aspell-docbook/Documentation/DocBook/writing_usb_driver.tmpl	
> 2006-09-21 22:45:30.000000000 +0200

ack

> diff -Nurp linux-2.6.18/Documentation/DocBook/z8530book.tmpl 
> linux-2.6.18-aspell-docbook/Documentation/DocBook/z8530book.tmpl
> --- linux-2.6.18/Documentation/DocBook/z8530book.tmpl	2006-09-20 
> 05:42:06.000000000 +0200
> +++ linux-2.6.18-aspell-docbook/Documentation/DocBook/z8530book.tmpl	
> 2006-09-21 22:47:59.000000000 +0200

ack

Thanks.
---
~Randy
