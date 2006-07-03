Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750937AbWGCIbi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937AbWGCIbi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 04:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750934AbWGCIbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 04:31:38 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:36640 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750771AbWGCIbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 04:31:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=rrplfN81Yj1M24OdXmwcMlYP5avfFIow9c7r/MhAdxo2KGJy9zPX4HucCZ8Bgf6rzXqdJR2KOSbF9MCq2yDIhfxrwvzCOZYYu/gDuTp5rbvUA+FOQZqaq7RN0o8xxokr2Ob34IMgOlGBL6vAdl7ksobKnZsCZBunCjXEx8RCEXw=
Message-ID: <a44ae5cd0607030131x745b3106ydd2a4ca086cdf401@mail.gmail.com>
Date: Mon, 3 Jul 2006 01:31:36 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.17-mm5 -- netconsole failed to send full trace
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get a system lockup on my laptop every time I remove my Linksys USB
10/100 Ethernet adapter.  Unfortunately, my laptop has no serial port,
so debugging this kernel is difficult.  I tried netconsole tonight,
but only got:

BUG: unable to handle kernel paging request at virtual address 6b6b6b6b
 printing eip:
c101a44d
*pde = 00000000
Oops: 0000 [#1]
4K_STACKS PREEMPT
last sysfs file: /block/hda/hda9/stat
Modules linked in: netconsole binfmt_misc i915 drm ipv6
speedstep_centrino cpufreq_powersave cpufreq_performance
cpufreq_conservative video thermal button nls_ascii nls_cp437 vfat fat
nls_utf8 ntfs nls_base md_mod sr_mod sbp2 scsi_mod parport_pc lp
parport rtl8150 snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm_oss
snd_mixer_oss snd_pcm snd_timer snd evdev soundcore ipw2200
intel_agpc3 89 e5 53 fa 61 0b 01 1d 14 c1 c7 14 3c 00 00 00 b0 1a 00
eb <8b> 8b 43 85 75

What should I try now?  I somehow doubt that I can make the kernel
send info to a USB tty port.

Thanks,
         Miles
