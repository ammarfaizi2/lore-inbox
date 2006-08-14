Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932384AbWHNOZD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbWHNOZD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 10:25:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932478AbWHNOZB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 10:25:01 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:2795 "EHLO
	pd4mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S932384AbWHNOZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 10:25:00 -0400
Date: Mon, 14 Aug 2006 08:23:37 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: HT not active
In-reply-to: <fa.YLv8m2Uw0It/GRKxQHnEfBS+Dao@ifi.uio.no>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <44E08769.7010000@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.YLv8m2Uw0It/GRKxQHnEfBS+Dao@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
> I cannot get HT to be used on some machine:
> 
> w04a# cat /proc/cpuinfo 
> processor       : 0
> vendor_id       : GenuineIntel
> cpu family      : 15
> model           : 0
> model name      : Intel(R) Pentium(R) 4 CPU 1700MHz
> stepping        : 10
> cpu MHz         : 1694.890
> cache size      : 256 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 2
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
> cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm up
> bogomips        : 3393.46
> 
> 'ht' indicates:
> #define X86_FEATURE_HT          (0*32+28) /* Hyper-Threading */                 

Most P4s that I have seen have the HT flag but only some of them 
actually support it (and have it enabled in the BIOS). I don't think any 
1.7GHz models did.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

