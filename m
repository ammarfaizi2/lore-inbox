Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964796AbWJTMa2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbWJTMa2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 08:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964803AbWJTMa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 08:30:28 -0400
Received: from cicero1.cybercity.dk ([212.242.40.4]:21502 "EHLO
	cicero1.cybercity.dk") by vger.kernel.org with ESMTP
	id S964796AbWJTMa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 08:30:26 -0400
Message-ID: <4538C156.3060502@molgaard.org>
Date: Fri, 20 Oct 2006 14:30:14 +0200
From: =?ISO-8859-1?Q?Sune_M=F8lgaard?= <sune@molgaard.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060717 Debian/1.7.13-0.2ubuntu1
X-Accept-Language: en
MIME-Version: 1.0
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
CC: Jiri Slaby <jirislaby@gmail.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org
Subject: Re: speedstep-centrino: ENODEV
References: <EB12A50964762B4D8111D55B764A8454C1A976@scsmsx413.amr.corp.intel.com>
In-Reply-To: <EB12A50964762B4D8111D55B764A8454C1A976@scsmsx413.amr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pallipadi, Venkatesh wrote:
>  
> 
> Puzzling.. 
> Just to make sure, do you have CPU_FREQ_DEBUG enabled in your config and boot parameter? There are a bunch of dprintk debug messages in speedstep_centrino that should get printed in this case..
> Do you have est flag displayed in your /proc/cpuinfo under flags?
> 

Well, how about that. No est :-$ I assume ss is regular speedstep? So 
what do I use instead? Is there some way to get acpi-speedstep working 
again?

Best regards,

/sunem

sune@tommelise:~$ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 13
model name      : Intel(R) Celeron(R) M processor         1.40GHz
stepping        : 8
cpu MHz         : 1396.494
cache size      : 1024 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat clflush dts acpi mmx fxsr sse sse2 ss tm pbe nx up
bogomips        : 2795.99
