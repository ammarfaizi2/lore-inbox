Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261436AbUBYVJP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 16:09:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261469AbUBYVJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 16:09:15 -0500
Received: from fmr11.intel.com ([192.55.52.31]:3508 "EHLO
	fmsfmr004.fm.intel.com") by vger.kernel.org with ESMTP
	id S261436AbUBYVHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 16:07:10 -0500
Subject: Re: ACPI fail in kernel 2.4.25 and 2.6.3
From: Len Brown <len.brown@intel.com>
To: Javier Gonzalez <javi@l0r0.com>
Cc: linux-kernel@vger.kernel.org,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615F316E@hdsmsx402.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615F316E@hdsmsx402.hd.intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Organization: 
Message-Id: <1077742905.5913.475.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 25 Feb 2004 16:06:58 -0500
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Javier,
yes, we've seen this regression on other systems.
Perhaps you can help us debug it -- we need the output of acpidmp from a
failing system attached to this bug report.

Battery status regression -- AE_ALREADY_EXISTS
http://bugme.osdl.org/show_bug.cgi?id=2066

thanks,
-Len

On Tue, 2004-02-24 at 18:09, Javier Gonzalez wrote:
> Hi!
> 
> Recently I have upgraded my kernel from 2.4.22-AlanCoxPatch. I have an
> Acer Travelmate 290LMi laptop (Centrino). All worked well with 2.4.22
> but i have problems with new kernels.
> 
> With 2.4.25 + cpufreq patch from
> ftp://ftp.linux.org.uk/pub/linux/cpufreq/ and a few minutes after boot
> (when i try to know battery state with acpi command) i get this
> "bucle"
> error:
> 
> Feb 24 23:47:00 localhost kernel: acpi_battery-0195 [1619]
> acpi_battery_get_statu: Error evaluating _BST
> Feb 24 23:47:01 localhost kernel:  dswload-0279: *** Error: Looking up
> [PBST] in namespace, AE_ALREADY_EXISTS
> Feb 24 23:47:01 localhost kernel:  psparse-0588 [1626]
> ps_parse_loop         : During name lookup/catalog, AE_ALREADY_EXISTS
> Feb 24 23:47:01 localhost kernel:  psparse-1120: *** Error: Method
> execution failed [\_SB_.PCI0.LPC0.BAT1._BST] (Node c1562528),
> AE_ALREADY_EXISTS
> 
> I tried with 2.6.3 and y get the same error :-( 
> 
> I have twho friends with diferents laptops who have the same problem.
> 
> Thank for your help.
> 
> -- 
> Un saludo:
> 
>                             Javier González
>                    GNU/Linux registered user #302650
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

