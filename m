Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932186AbWHVQVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbWHVQVv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 12:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbWHVQVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 12:21:51 -0400
Received: from xenotime.net ([66.160.160.81]:49062 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751414AbWHVQVv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 12:21:51 -0400
Date: Tue, 22 Aug 2006 09:24:58 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: linux-kernel@vger.kernel.org, device@lanana.org
Subject: Re: [PATCH] Update Documentation/devices.txt
Message-Id: <20060822092458.7fbc5286.rdunlap@xenotime.net>
In-Reply-To: <87d5aserky.fsf@slug.be.48ers.dk>
References: <87d5aserky.fsf@slug.be.48ers.dk>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Aug 2006 17:08:13 +0200 Peter Korsgaard wrote:

> Hi,
> 
> Sync Documentation/devices.txt with the new version from the LANANA
> site (http://www.lanana.org/docs/device-list/devices-2.6+.txt)
> 
> Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
> 
> diff -urpN linux-2.6.18-rc4.orig/Documentation/devices.txt linux-2.6.18-rc4/Documentation/devices.txt
> --- linux-2.6.18-rc4.orig/Documentation/devices.txt	2006-08-22 16:58:14.000000000 +0200
> +++ linux-2.6.18-rc4/Documentation/devices.txt	2006-08-22 16:57:21.000000000 +0200
> @@ -3,7 +3,7 @@
>  
>  	     Maintained by Torben Mathiasen <device@lanana.org>

Maybe Torben could update or ack/nack or comment?

> @@ -1522,7 +1522,7 @@ Your cooperation is appreciated.
>  		disks (see major number 3) except that the limit on
>  		partitions is 15.
>  
> - 83 char	Matrox mga_vid video driver
> + 83 char	Matrox mga_vid video driver 

Please don't add trailing whitespace like above.

> @@ -1731,7 +1731,7 @@ Your cooperation is appreciated.
>  		  0 = /dev/ubda		First user-mode block device
>  		 16 = /dev/udbb		Second user-mode block device
>  		    ...
> -
> +		

More trailing whitespace above.

>  		Partitions are handled in the same way as for IDE
>  		disks (see major number 3) except that the limit on
>  		partitions is 15.
> @@ -2305,7 +2305,7 @@ Your cooperation is appreciated.
>  		  0 = /dev/drbd0	First DRBD device
>  		  1 = /dev/drbd1	Second DRBD device
>  		    ...
> -
> +		

ditto.

>  148 char	Technology Concepts serial card
>  		  0 = /dev/ttyT0	First TCL port
>  		  1 = /dev/ttyT1	Second TCL port
> @@ -2767,7 +2767,7 @@ Your cooperation is appreciated.
>  		 42 = /dev/ttySMX1		Motorola i.MX - port 1
>  		 43 = /dev/ttySMX2		Motorola i.MX - port 2
>  		 44 = /dev/ttyMM0		Marvell MPSC - port 0
> -		 45 = /dev/ttyMM1		Marvell MPSC - port 1
> +		 45 = /dev/ttyMM1		Marvell MPSC - port 1	

again

>  		 46 = /dev/ttyCPM0		PPC CPM (SCC or SMC) - port 0
>  		    ...
>  		 47 = /dev/ttyCPM5		PPC CPM (SCC or SMC) - port 5
> @@ -3005,11 +3008,11 @@ Your cooperation is appreciated.
>  		  2 = /dev/3270/tub2		Second 3270 terminal
>  		    ...
>  
> -229 char	IBM iSeries virtual console
> -		  0 = /dev/iseries/vtty0	First console port
> -		  1 = /dev/iseries/vtty1	Second console port
> +229 char	IBM iSeries/pSeries virtual console
> +		  0 = /dev/hvc0			First console port
> +		  1 = /dev/hvc1			Second console port
>  		    ...
> -
> +		  

again

>  230 char	IBM iSeries virtual tape
>  		  0 = /dev/iseries/vt0		First virtual tape, mode 0
>  		  1 = /dev/iseries/vt1		Second virtual tape, mode 0
> @@ -3091,7 +3094,7 @@ Your cooperation is appreciated.
>  		This major is reserved to assist the expansion to a
>  		larger number space.  No device nodes with this major
>  		should ever be created on the filesystem.
> -		(This is probaly not true anymore, but I'll leave it
> +		(This is probaly not true anymore, but I'll leave it 

whitespace.  again.
and s/probaly/probably/

>  		for now /Torben)


---
~Randy
