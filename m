Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261475AbVE0DWY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261475AbVE0DWY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 23:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbVE0DWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 23:22:24 -0400
Received: from redpine-92-161-hyd.redpinesignals.com ([203.196.161.92]:63443
	"EHLO redpinesignals.com") by vger.kernel.org with ESMTP
	id S261475AbVE0DWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 23:22:15 -0400
Message-ID: <4296952A.4080309@redpinesignals.com>
Date: Fri, 27 May 2005 09:04:02 +0530
From: P Lavin <lavin.p@redpinesignals.com>
Reply-To: lavin.p@redpinesignals.com
Organization: www.redpinesignals.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Error in building modules into kernel.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Can anyone tell me why i'm getting this error when i'm trying to build 
my driver into kernel ??
I'm using fedora-2 with linux-2.6.6

 SPLIT   include/linux/autoconf.h -> include/config/*
make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
  CHK     include/asm-i386/asm_offsets.h
  CHK     include/linux/compile.h
  IKCFG   kernel/ikconfig.h
  CC      kernel/configs.o
  LD      kernel/built-in.o
  CC      drivers/net/wireless/rsi_pine1/driver/pci.o
  CC      drivers/net/wireless/rsi_pine1/driver/if.o
  CC      drivers/net/wireless/rsi_pine1/driver/rsi_mem.o
  CC      drivers/net/wireless/rsi_pine1/802dot11/wlm/src/macdrv.o
  CC      drivers/net/wireless/rsi_pine1/802dot11/mlme/src/miscmg.o
  CC      drivers/net/wireless/rsi_pine1/802dot11/mlme/src/mlme.o
  CC      drivers/net/wireless/rsi_pine1/802dot11/mlme/src/mlmib.o
  CC      drivers/net/wireless/rsi_pine1/802dot11/mlme/src/mlmstaif.o
  CC      drivers/net/wireless/rsi_pine1/802dot11/mlme/src/mpool.o
  CC      drivers/net/wireless/rsi_pine1/802dot11/mlme/src/utilmg.o
  CC      drivers/net/wireless/rsi_pine1/802dot11/common/src/utils.o
  CC      drivers/net/wireless/rsi_pine1/802dot11/wlm/src/wlm.o
  CC      drivers/net/wireless/rsi_pine1/802dot11/mlme/src/assocmg.o
  CC      drivers/net/wireless/rsi_pine1/802dot11/mlme/src/authmg.o
  CC      drivers/net/wireless/rsi_pine1/802dot11/mlme/src/mlmapif.o
  CC      drivers/net/wireless/rsi_pine1/802dot11/psmgmt/src/psmgmt.o
  CC      
drivers/net/wireless/rsi_pine1/802dot11/qos/src/_rsi_wlan_qos_mlme.o
  CC      
drivers/net/wireless/rsi_pine1/802dot11/qos/src/_rsi_wlan_qos_mlme_if.o
  CC      
drivers/net/wireless/rsi_pine1/802dot11/qos/src/_rsi_wlan_qos_util.o
  CC      
drivers/net/wireless/rsi_pine1/802dot11/qos/src/_rsi_wlan_qos_dlp.o
  CC      
drivers/net/wireless/rsi_pine1/802dot11/qos/src/_rsi_wlan_qos_dlp_if.o
  CC      drivers/net/wireless/rsi_pine1/wpa/rc4.o
  CC      drivers/net/wireless/rsi_pine1/wpa/aes_wrap.o
  CC      drivers/net/wireless/rsi_pine1/wpa/md5.o
  CC      drivers/net/wireless/rsi_pine1/wpa/sha1.o
  CC      drivers/net/wireless/rsi_pine1/wpa/common.o
  CC      drivers/net/wireless/rsi_pine1/wpa/wpa_ap.o
  CC      drivers/net/wireless/rsi_pine1/wpa/ieee802_1x.o
  LD      drivers/net/wireless/rsi_pine1/rsiap.o
  LD      drivers/net/wireless/rsi_pine1/built-in.o
  LD      drivers/net/wireless/built-in.o
  LD      drivers/net/built-in.o
  LD      drivers/built-in.o
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
drivers/built-in.o(.exit.text+0xdab): In function `cleanup_module':
: multiple definition of `cleanup_module'
kernel/built-in.o(.text+0x18f0c): first defined here
ld: Warning: size of symbol `cleanup_module' changed from 1 in 
kernel/built-in.o to 40 in drivers/built-in.o
drivers/built-in.o(.init.text+0xf9fb): In function `init_module':
: multiple definition of `init_module'
kernel/built-in.o(.text+0x18580): first defined here
ld: Warning: size of symbol `init_module' changed from 3 in 
kernel/built-in.o to 166 in drivers/built-in.o
make: *** [.tmp_vmlinux1] Error 1

Rgds,
Lavin
-- 
*/*/Life is not measured by the number of breaths we take; but by the 
moments that take our breath away !!!
/* /*
P.Lavin
Software Engineer,
Redpine Signals ,Inc.
Hyderabad.
http://www.redpinesignals.com

