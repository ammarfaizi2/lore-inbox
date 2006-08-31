Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932315AbWHaTO0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbWHaTO0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 15:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932150AbWHaTO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 15:14:26 -0400
Received: from hera.kernel.org ([140.211.167.34]:35756 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932315AbWHaTOZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 15:14:25 -0400
From: Len Brown <len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
To: Pavel Machek <pavel@suse.cz>
Subject: Re: ibm-acpi documentation: delete irrelevant "how to compile external module"
Date: Thu, 31 Aug 2006 15:16:00 -0400
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>,
       borislav@users.sourceforge.net
References: <20060831121554.GV3923@elf.ucw.cz>
In-Reply-To: <20060831121554.GV3923@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608311516.00435.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.
thanks,
-Len

On Thursday 31 August 2006 08:15, Pavel Machek wrote:
> 
> ibm-acpi documentation contains parts that are no longer relevant
> because ibm-acpi was merged.
> 
> Signed-off-by: Pavel Machek <pavel@suse.cz>
> 
> diff --git a/Documentation/ibm-acpi.txt b/Documentation/ibm-acpi.txt
> index 8b3fd82..8d57efa 100644
> --- a/Documentation/ibm-acpi.txt
> +++ b/Documentation/ibm-acpi.txt
> @@ -52,40 +52,7 @@ Installation
>  
>  If you are compiling this driver as included in the Linux kernel
>  sources, simply enable the CONFIG_ACPI_IBM option (Power Management /
> -ACPI / IBM ThinkPad Laptop Extras). The rest of this section describes
> -how to install this driver when downloaded from the web site.
> -
> -First, you need to get a kernel with ACPI support up and running.
> -Please refer to http://acpi.sourceforge.net/ for help with this
> -step. How successful you will be depends a lot on you ThinkPad model,
> -the kernel you are using and any additional patches applied. The
> -kernel provided with your distribution may not be good enough. I
> -needed to compile a 2.6.7 kernel with the 20040715 ACPI patch to get
> -ACPI working reliably on my ThinkPad X40. Old ThinkPad models may not
> -be supported at all.
> -
> -Assuming you have the basic ACPI support working (e.g. you can see the
> -/proc/acpi directory), follow the following steps to install this
> -driver:
> -
> -	- unpack the archive:
> -
> -		tar xzvf ibm-acpi-x.y.tar.gz; cd ibm-acpi-x.y
> -
> -	- compile the driver:
> -
> -		make
> -
> -	- install the module in your kernel modules directory:
> -
> -		make install
> -
> -	- load the module:
> -
> -		modprobe ibm_acpi
> -
> -After loading the module, check the "dmesg" output for any error messages.
> -
> +ACPI / IBM ThinkPad Laptop Extras).
>  
>  Features
>  --------
> 
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
