Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261362AbULHVLH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbULHVLH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 16:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261363AbULHVLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 16:11:07 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:35533 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261362AbULHVKR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 16:10:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=FgPGVE+9NsSZUR3KtXqbT/NhP7rc315V77eK1zzTEY9zvdwepWXtAIwS/qq5kfx0PYsFVvEvf/XIQVTyYzj9mzm12O7I5vrixvzaXX6xZdET5/hJStaNXID7cs/pks4WkWNfTgO9/5q+qDon1Y1Qk6FaMYgymC/IsSOj54SoV/k=
Message-ID: <aee4c5bc041208131038134e9a@mail.gmail.com>
Date: Wed, 8 Dec 2004 22:10:16 +0100
From: Benoit Dejean <bdejean@gmail.com>
Reply-To: Benoit Dejean <bdejean@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [ppc32] 2.6.10-rc3-bk3 warnings
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
here are the warnings i got with gcc-3.3.5 and defconfig


arch/ppc/platforms/pmac_cpufreq.c: In function `pmu_set_cpu_speed':
arch/ppc/platforms/pmac_cpufreq.c:226: warning: implicit declaration
of function `enable_kernel_altivec'
arch/ppc/syslib/prom.c: In function `map_interrupt':
arch/ppc/syslib/prom.c:311: warning: `newintrc' might be used
uninitialized in this function
arch/ppc/syslib/prom.c:311: warning: `newaddrc' might be used
uninitialized in this function

kernel/intermodule.c:179: warning: `inter_module_register' is
deprecated (declared at kernel/intermodule.c:38)
kernel/intermodule.c:180: warning: `inter_module_unregister' is
deprecated (declared at kernel/intermodule.c:79)
kernel/intermodule.c:183: warning: `inter_module_put' is deprecated
(declared at kernel/intermodule.c:160)

mm/filemap.c: In function `filemap_nopage':
mm/filemap.c:1140: warning: `endoff' might be used uninitialized in
this function
drivers/cpufreq/proc_intf.c:15:2: warning: #warning This module will
be removed from the 2.6. kernel series soon after 2005-01-01



In file included from drivers/net/wireless/orinoco.c:448:
drivers/net/wireless/hermes.h: In function `hermes_present':
drivers/net/wireless/hermes.h:398: warning: passing arg 1 of `readw'
makes pointer from integer without a cast
drivers/net/wireless/hermes.h: In function `hermes_set_irqmask':
drivers/net/wireless/hermes.h:404: warning: passing arg 2 of `writew'
makes pointer from integer without a cast
drivers/net/wireless/hermes.h: In function `hermes_read_words':
drivers/net/wireless/hermes.h:445: warning: passing arg 1 of `readw'
makes pointer from integer without a cast
drivers/net/wireless/hermes.h:445: warning: passing arg 1 of `readw'
makes pointer from integer without a cast
drivers/net/wireless/hermes.h:445: warning: passing arg 1 of `readw'
makes pointer from integer without a cast
drivers/net/wireless/hermes.h: In function `hermes_write_words':
drivers/net/wireless/hermes.h:465: warning: passing arg 2 of `writew'
makes pointer from integer without a cast
drivers/net/wireless/hermes.h: In function `hermes_clear_words':
drivers/net/wireless/hermes.h:481: warning: passing arg 2 of `writew'
makes pointer from integer without a cast
drivers/net/wireless/orinoco.c: In function `__orinoco_ev_alloc':
drivers/net/wireless/orinoco.c:895: warning: passing arg 1 of `readw'
makes pointer from integer without a cast
drivers/net/wireless/orinoco.c:906: warning: passing arg 2 of `writew'
makes pointer from integer without a cast
drivers/net/wireless/orinoco.c: In function `__orinoco_ev_tx':
drivers/net/wireless/orinoco.c:916: warning: passing arg 2 of `writew'
makes pointer from integer without a cast
drivers/net/wireless/orinoco.c: In function `__orinoco_ev_txexc':
drivers/net/wireless/orinoco.c:923: warning: passing arg 1 of `readw'
makes pointer from integer without a cast
drivers/net/wireless/orinoco.c:942: warning: passing arg 2 of `writew'
makes pointer from integer without a cast
drivers/net/wireless/orinoco.c: In function `orinoco_tx_timeout':
drivers/net/wireless/orinoco.c:953: warning: passing arg 1 of `readw'
makes pointer from integer without a cast
drivers/net/wireless/orinoco.c:954: warning: passing arg 1 of `readw'
makes pointer from integer without a cast
drivers/net/wireless/orinoco.c:954: warning: passing arg 1 of `readw'
makes pointer from integer without a cast
drivers/net/wireless/orinoco.c: In function `__orinoco_ev_rx':
drivers/net/wireless/orinoco.c:1031: warning: passing arg 1 of `readw'
makes pointer from integer without a cast
drivers/net/wireless/orinoco.c: In function `__orinoco_ev_info':
drivers/net/wireless/orinoco.c:1225: warning: passing arg 1 of `readw'
makes pointer from integer without a cast
drivers/net/wireless/orinoco.c: In function `__orinoco_down':
drivers/net/wireless/orinoco.c:1367: warning: passing arg 2 of
`writew' makes pointer from integer without a cast
drivers/net/wireless/orinoco.c: In function `orinoco_reset':
drivers/net/wireless/orinoco.c:1882: warning: passing arg 2 of
`writew' makes pointer from integer without a cast
drivers/net/wireless/orinoco.c: In function `orinoco_interrupt':
drivers/net/wireless/orinoco.c:1964: warning: passing arg 1 of `readw'
makes pointer from integer without a cast
drivers/net/wireless/orinoco.c:2008: warning: passing arg 2 of
`writew' makes pointer from integer without a cast
drivers/net/wireless/orinoco.c:2010: warning: passing arg 1 of `readw'
makes pointer from integer without a cast
In file included from drivers/net/wireless/hermes.c:53:
drivers/net/wireless/hermes.h: In function `hermes_present':
drivers/net/wireless/hermes.h:398: warning: passing arg 1 of `readw'
makes pointer from integer without a cast
drivers/net/wireless/hermes.h: In function `hermes_set_irqmask':
drivers/net/wireless/hermes.h:404: warning: passing arg 2 of `writew'
makes pointer from integer without a cast
drivers/net/wireless/hermes.h: In function `hermes_read_words':
drivers/net/wireless/hermes.h:445: warning: passing arg 1 of `readw'
makes pointer from integer without a cast
drivers/net/wireless/hermes.h:445: warning: passing arg 1 of `readw'
makes pointer from integer without a cast
drivers/net/wireless/hermes.h:445: warning: passing arg 1 of `readw'
makes pointer from integer without a cast
drivers/net/wireless/hermes.h: In function `hermes_write_words':
drivers/net/wireless/hermes.h:465: warning: passing arg 2 of `writew'
makes pointer from integer without a cast
drivers/net/wireless/hermes.h: In function `hermes_clear_words':
drivers/net/wireless/hermes.h:481: warning: passing arg 2 of `writew'
makes pointer from integer without a cast
drivers/net/wireless/hermes.c: In function `hermes_issue_cmd':
drivers/net/wireless/hermes.c:104: warning: passing arg 1 of `readw'
makes pointer from integer without a cast
drivers/net/wireless/hermes.c:108: warning: passing arg 1 of `readw'
makes pointer from integer without a cast
drivers/net/wireless/hermes.c:114: warning: passing arg 2 of `writew'
makes pointer from integer without a cast
drivers/net/wireless/hermes.c:115: warning: passing arg 2 of `writew'
makes pointer from integer without a cast
drivers/net/wireless/hermes.c:116: warning: passing arg 2 of `writew'
makes pointer from integer without a cast
drivers/net/wireless/hermes.c:117: warning: passing arg 2 of `writew'
makes pointer from integer without a cast
drivers/net/wireless/hermes.c: In function `hermes_init':
drivers/net/wireless/hermes.c:149: warning: passing arg 2 of `writew'
makes pointer from integer without a cast
drivers/net/wireless/hermes.c:150: warning: passing arg 2 of `writew'
makes pointer from integer without a cast
drivers/net/wireless/hermes.c:159: warning: passing arg 1 of `readw'
makes pointer from integer without a cast
drivers/net/wireless/hermes.c:167: warning: passing arg 1 of `readw'
makes pointer from integer without a cast
drivers/net/wireless/hermes.c:176: warning: passing arg 1 of `readw'
makes pointer from integer without a cast
drivers/net/wireless/hermes.c:177: warning: passing arg 2 of `writew'
makes pointer from integer without a cast
drivers/net/wireless/hermes.c:185: warning: passing arg 1 of `readw'
makes pointer from integer without a cast
drivers/net/wireless/hermes.c:190: warning: passing arg 1 of `readw'
makes pointer from integer without a cast
drivers/net/wireless/hermes.c:193: warning: passing arg 2 of `writew'
makes pointer from integer without a cast
drivers/net/wireless/hermes.c:210: warning: passing arg 1 of `readw'
makes pointer from integer without a cast
drivers/net/wireless/hermes.c:212: warning: passing arg 2 of `writew'
makes pointer from integer without a cast
drivers/net/wireless/hermes.c: In function `hermes_docmd_wait':
drivers/net/wireless/hermes.c:248: warning: passing arg 1 of `readw'
makes pointer from integer without a cast
drivers/net/wireless/hermes.c:253: warning: passing arg 1 of `readw'
makes pointer from integer without a cast
drivers/net/wireless/hermes.c:272: warning: passing arg 1 of `readw'
makes pointer from integer without a cast
drivers/net/wireless/hermes.c:275: warning: passing arg 1 of `readw'
makes pointer from integer without a cast
drivers/net/wireless/hermes.c:276: warning: passing arg 1 of `readw'
makes pointer from integer without a cast
drivers/net/wireless/hermes.c:277: warning: passing arg 1 of `readw'
makes pointer from integer without a cast
drivers/net/wireless/hermes.c:280: warning: passing arg 2 of `writew'
makes pointer from integer without a cast
drivers/net/wireless/hermes.c: In function `hermes_allocate':
drivers/net/wireless/hermes.c:303: warning: passing arg 1 of `readw'
makes pointer from integer without a cast
drivers/net/wireless/hermes.c:308: warning: passing arg 1 of `readw'
makes pointer from integer without a cast
drivers/net/wireless/hermes.c:325: warning: passing arg 1 of `readw'
makes pointer from integer without a cast
drivers/net/wireless/hermes.c:326: warning: passing arg 2 of `writew'
makes pointer from integer without a cast
drivers/net/wireless/hermes.c: In function `hermes_bap_seek':
drivers/net/wireless/hermes.c:350: warning: passing arg 1 of `readw'
makes pointer from integer without a cast
drivers/net/wireless/hermes.c:354: warning: passing arg 1 of `readw'
makes pointer from integer without a cast
drivers/net/wireless/hermes.c:374: warning: passing arg 2 of `writew'
makes pointer from integer without a cast
drivers/net/wireless/hermes.c:375: warning: passing arg 2 of `writew'
makes pointer from integer without a cast
drivers/net/wireless/hermes.c:379: warning: passing arg 1 of `readw'
makes pointer from integer without a cast
drivers/net/wireless/hermes.c:383: warning: passing arg 1 of `readw'
makes pointer from integer without a cast
drivers/net/wireless/hermes.c: In function `hermes_read_ltv':
drivers/net/wireless/hermes.c:476: warning: passing arg 1 of `readw'
makes pointer from integer without a cast
drivers/net/wireless/hermes.c:481: warning: passing arg 1 of `readw'
makes pointer from integer without a cast
drivers/net/wireless/hermes.c: In function `hermes_write_ltv':
drivers/net/wireless/hermes.c:517: warning: passing arg 2 of `writew'
makes pointer from integer without a cast
drivers/net/wireless/hermes.c:518: warning: passing arg 2 of `writew'
makes pointer from integer without a cast
In file included from drivers/net/wireless/orinoco.h:18,
                 from drivers/net/wireless/airport.c:42:
drivers/net/wireless/hermes.h: In function `hermes_present':
drivers/net/wireless/hermes.h:398: warning: passing arg 1 of `readw'
makes pointer from integer without a cast
drivers/net/wireless/hermes.h: In function `hermes_set_irqmask':
drivers/net/wireless/hermes.h:404: warning: passing arg 2 of `writew'
makes pointer from integer without a cast
drivers/net/wireless/hermes.h: In function `hermes_read_words':
drivers/net/wireless/hermes.h:445: warning: passing arg 1 of `readw'
makes pointer from integer without a cast
drivers/net/wireless/hermes.h:445: warning: passing arg 1 of `readw'
makes pointer from integer without a cast
drivers/net/wireless/hermes.h:445: warning: passing arg 1 of `readw'
makes pointer from integer without a cast
drivers/net/wireless/hermes.h: In function `hermes_write_words':
drivers/net/wireless/hermes.h:465: warning: passing arg 2 of `writew'
makes pointer from integer without a cast
drivers/net/wireless/hermes.h: In function `hermes_clear_words':
drivers/net/wireless/hermes.h:481: warning: passing arg 2 of `writew'
makes pointer from integer without a cast
drivers/scsi/aic7xxx/aic7xxx_osm_pci.c: In function `ahc_linux_pci_dev_probe':
drivers/scsi/aic7xxx/aic7xxx_osm_pci.c:229: warning: large integer
implicitly truncated to unsigned type
drivers/video/cfbcopyarea.c: In function `bitcpy':
drivers/video/cfbcopyarea.c:69: warning: passing arg 1 of
`__raw_readl' discards qualifiers from pointer target type
drivers/video/cfbcopyarea.c:75: warning: passing arg 1 of
`__raw_readl' discards qualifiers from pointer target type
drivers/video/cfbcopyarea.c:85: warning: passing arg 1 of
`__raw_readl' discards qualifiers from pointer target type
drivers/video/cfbcopyarea.c:86: warning: passing arg 1 of
`__raw_readl' discards qualifiers from pointer target type
drivers/video/cfbcopyarea.c:87: warning: passing arg 1 of
`__raw_readl' discards qualifiers from pointer target type
drivers/video/cfbcopyarea.c:88: warning: passing arg 1 of
`__raw_readl' discards qualifiers from pointer target type
drivers/video/cfbcopyarea.c:89: warning: passing arg 1 of
`__raw_readl' discards qualifiers from pointer target type
drivers/video/cfbcopyarea.c:90: warning: passing arg 1 of
`__raw_readl' discards qualifiers from pointer target type
drivers/video/cfbcopyarea.c:91: warning: passing arg 1 of
`__raw_readl' discards qualifiers from pointer target type
drivers/video/cfbcopyarea.c:92: warning: passing arg 1 of
`__raw_readl' discards qualifiers from pointer target type
drivers/video/cfbcopyarea.c:96: warning: passing arg 1 of
`__raw_readl' discards qualifiers from pointer target type
drivers/video/cfbcopyarea.c:99: warning: passing arg 1 of
`__raw_readl' discards qualifiers from pointer target type
drivers/video/cfbcopyarea.c:113: warning: passing arg 1 of
`__raw_readl' discards qualifiers from pointer target type
drivers/video/cfbcopyarea.c:117: warning: passing arg 1 of
`__raw_readl' discards qualifiers from pointer target type
drivers/video/cfbcopyarea.c:121: warning: passing arg 1 of
`__raw_readl' discards qualifiers from pointer target type
drivers/video/cfbcopyarea.c:122: warning: passing arg 1 of
`__raw_readl' discards qualifiers from pointer target type
drivers/video/cfbcopyarea.c:128: warning: passing arg 1 of
`__raw_readl' discards qualifiers from pointer target type
drivers/video/cfbcopyarea.c:138: warning: passing arg 1 of
`__raw_readl' discards qualifiers from pointer target type
drivers/video/cfbcopyarea.c:150: warning: passing arg 1 of
`__raw_readl' discards qualifiers from pointer target type
drivers/video/cfbcopyarea.c:153: warning: passing arg 1 of
`__raw_readl' discards qualifiers from pointer target type
drivers/video/cfbcopyarea.c:156: warning: passing arg 1 of
`__raw_readl' discards qualifiers from pointer target type
drivers/video/cfbcopyarea.c:159: warning: passing arg 1 of
`__raw_readl' discards qualifiers from pointer target type
drivers/video/cfbcopyarea.c:165: warning: passing arg 1 of
`__raw_readl' discards qualifiers from pointer target type
drivers/video/cfbcopyarea.c:179: warning: passing arg 1 of
`__raw_readl' discards qualifiers from pointer target type
drivers/video/cfbcopyarea.c: In function `bitcpy_rev':
drivers/video/cfbcopyarea.c:222: warning: passing arg 1 of
`__raw_readl' discards qualifiers from pointer target type
drivers/video/cfbcopyarea.c:227: warning: passing arg 1 of
`__raw_readl' discards qualifiers from pointer target type
drivers/video/cfbcopyarea.c:236: warning: passing arg 1 of
`__raw_readl' discards qualifiers from pointer target type
drivers/video/cfbcopyarea.c:237: warning: passing arg 1 of
`__raw_readl' discards qualifiers from pointer target type
drivers/video/cfbcopyarea.c:238: warning: passing arg 1 of
`__raw_readl' discards qualifiers from pointer target type
drivers/video/cfbcopyarea.c:239: warning: passing arg 1 of
`__raw_readl' discards qualifiers from pointer target type
drivers/video/cfbcopyarea.c:240: warning: passing arg 1 of
`__raw_readl' discards qualifiers from pointer target type
drivers/video/cfbcopyarea.c:241: warning: passing arg 1 of
`__raw_readl' discards qualifiers from pointer target type
drivers/video/cfbcopyarea.c:242: warning: passing arg 1 of
`__raw_readl' discards qualifiers from pointer target type
drivers/video/cfbcopyarea.c:243: warning: passing arg 1 of
`__raw_readl' discards qualifiers from pointer target type
drivers/video/cfbcopyarea.c:247: warning: passing arg 1 of
`__raw_readl' discards qualifiers from pointer target type
drivers/video/cfbcopyarea.c:251: warning: passing arg 1 of
`__raw_readl' discards qualifiers from pointer target type
drivers/video/cfbcopyarea.c:265: warning: passing arg 1 of
`__raw_readl' discards qualifiers from pointer target type
drivers/video/cfbcopyarea.c:269: warning: passing arg 1 of
`__raw_readl' discards qualifiers from pointer target type
drivers/video/cfbcopyarea.c:273: warning: passing arg 1 of
`__raw_readl' discards qualifiers from pointer target type
drivers/video/cfbcopyarea.c:274: warning: passing arg 1 of
`__raw_readl' discards qualifiers from pointer target type
drivers/video/cfbcopyarea.c:280: warning: passing arg 1 of
`__raw_readl' discards qualifiers from pointer target type
drivers/video/cfbcopyarea.c:290: warning: passing arg 1 of
`__raw_readl' discards qualifiers from pointer target type
drivers/video/cfbcopyarea.c:302: warning: passing arg 1 of
`__raw_readl' discards qualifiers from pointer target type
drivers/video/cfbcopyarea.c:305: warning: passing arg 1 of
`__raw_readl' discards qualifiers from pointer target type
drivers/video/cfbcopyarea.c:308: warning: passing arg 1 of
`__raw_readl' discards qualifiers from pointer target type
drivers/video/cfbcopyarea.c:311: warning: passing arg 1 of
`__raw_readl' discards qualifiers from pointer target type
drivers/video/cfbcopyarea.c:317: warning: passing arg 1 of
`__raw_readl' discards qualifiers from pointer target type
drivers/video/cfbcopyarea.c:331: warning: passing arg 1 of
`__raw_readl' discards qualifiers from pointer target type
sound/core/memory.c: In function `copy_to_user_fromio':
sound/core/memory.c:270: warning: passing arg 2 of `memcpy_fromio'
discards qualifiers from pointer target type
sound/oss/dmasound/trans_16.c: In function `pmac_ctx_s8_read':
sound/oss/dmasound/trans_16.c:594: warning: `valr' might be used
uninitialized in this function
sound/oss/dmasound/trans_16.c: In function `pmac_ctx_u8_read':
sound/oss/dmasound/trans_16.c:643: warning: `valr' might be used
uninitialized in this function
sound/oss/dmasound/trans_16.c: In function `pmac_ctx_s16_read':
sound/oss/dmasound/trans_16.c:702: warning: `datar' might be used
uninitialized in this function
sound/oss/dmasound/trans_16.c: In function `pmac_ctx_u16_read':
sound/oss/dmasound/trans_16.c:750: warning: `datar' might be used
uninitialized in this function
sound/oss/dmasound/tas3001c.c: In function `tas3001c_write_biquad_list':
sound/oss/dmasound/tas3001c.c:400: warning: `rc' might be used
uninitialized in this function
sound/oss/dmasound/tas3001c.c: At top level:
sound/oss/dmasound/tas3001c.c:162: warning: `tas3001c_read_register'
defined but not used
sound/oss/dmasound/tas3004.c: In function `tas3004_set_mixer_level':
sound/oss/dmasound/tas3004.c:400: warning: `rc' might be used
uninitialized in this function
sound/oss/dmasound/tas3004.c: In function `tas3004_write_biquad_list':
sound/oss/dmasound/tas3004.c:593: warning: `rc' might be used
uninitialized in this function
sound/oss/dmasound/tas3004.c: At top level:
sound/oss/dmasound/tas3004.c:330: warning: `tas3004_read_register'
defined but not used

net/ipv4/netfilter/ipchains_core.c:1:2: warning: #warning ipchains is
obsolete, and will be removed soon.
