Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751185AbWCQHB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbWCQHB2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 02:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbWCQHB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 02:01:28 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:3516 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751185AbWCQHB1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 02:01:27 -0500
Date: Fri, 17 Mar 2006 08:25:19 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: emist emist <emistz@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel Oops-jprobe
Message-ID: <20060317025519.GA32497@in.ibm.com>
Reply-To: prasanna@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Greetings,
                                                                                                                                               
>The following oops occurs when probing the sys_open function.
>Following is the oops and a module with which the error can be
>replicated.

I tried to recreate this problem on 4-way i386 box, but could not
recreate it. Could you please send me your config file?

Thanks
Prasanna

>[17192145.756000] kobject sysensor: registering. parent: <NULL>, set:
>module
>[17192145.756000] kobject_hotplug
>[17192145.756000] fill_kobj_path: path = '/module/sysensor'
>[17192145.756000] kobject_hotplug: /sbin/udevsend module seq=1024
>HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add
>DEVPATH=/module/sysensor SUBSYSTEM=module[17192146.124000] Unable to
>handle kernel paging request at virtual address 080c9566
>[17192146.124000]  printing eip:
>[17192146.124000] c01c61ae
>[17192146.124000] *pde = 0e124067
>[17192146.124000] *pte = 00000000
>[17192146.124000] Oops: 0000 [#1]
>[17192146.124000] PREEMPT
>[17192146.124000] Modules linked in: sysensor ppp_deflate zlib_deflate
>bsd_comp ppp_async crc_ccitt ppp_generic slhc ipv6 acpi_cpufreq
>speedstep_lib cpufreq_powersave cpufreq_userspace serial_cs
>cpufreq_ondemand i915 pcmcia drm video battery container fan button
>thermal processor ac ohci1394 yenta_socket rsrc_nonstatic pcmcia_core
>ipw2200 ieee80211 ieee80211_crypt firmware_class b44 mii snd_intel8x0
>snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss snd_pcm
>shpchp pci_hotplug ehci_hcd uhci_hcd usbcore intel_agp agpgart rtc
>joydev md_mod dm_mod sr_mod sbp2 scsi_mod ieee1394 psmouse mousedev
>parport_pc lp parport unix

-- 
Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Email: prasanna@in.ibm.com
Ph: 91-80-51776329
