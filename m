Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263296AbTCUGoU>; Fri, 21 Mar 2003 01:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263300AbTCUGoU>; Fri, 21 Mar 2003 01:44:20 -0500
Received: from ims21.stu.nus.edu.sg ([137.132.14.228]:36935 "EHLO
	ims21.stu.nus.edu.sg") by vger.kernel.org with ESMTP
	id <S263296AbTCUGoS> convert rfc822-to-8bit; Fri, 21 Mar 2003 01:44:18 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: COMMON symbol errors during module building
Date: Fri, 21 Mar 2003 14:55:08 +0800
Message-ID: <720FB032F37C0D45A11085D881B03368A2B5C3@MBXSRV24.stu.nus.edu.sg>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: COMMON symbol errors during module building
Thread-Index: AcLvds9mM/+shPpnTiqKYKMyPTCqKw==
From: "Eng Se-Hsieng" <g0202512@nus.edu.sg>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 21 Mar 2003 06:55:09.0211 (UTC) FILETIME=[CFD976B0:01C2EF76]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

While building the Cisco VPN client for Linux, I obtained the following
COMMON symbol errors.

I have already checked all the files that this module depends on but I
cannot find any trace of these variables. 

Grateful for any assistance.

Thank you.

Regards,
Se-Hsieng

[root@73-33 vpnclient]# make -C /usr/src/linux-2.5.64 SUBDIRS=$PWD
modules
make: Entering directory `/usr/src/linux-2.5.64'
make -f scripts/Makefile.build obj=scripts
*** Warning: Overriding SUBDIRS on the command line can cause
***          inconsistencies
mkdir -p .tmp_versions
  Starting the build. KBUILD_BUILTIN= KBUILD_MODULES=1
make -f scripts/Makefile.build obj=/usr/src/vpnclient
  Building modules, stage 2.
make -rR -f scripts/Makefile.modpost
  scripts/modpost drivers/i2c/chips/adm1021.o
/usr/src/vpnclient/cisco_ipsec.o drivers/i2c/i2c-algo-bit.o
drivers/i2c/i2c-algo-pcf.o drivers/i2c/busses/i2c-amd756.o
drivers/i2c/i2c-core.o drivers/i2c/i2c-dev.o drivers/i2c/i2c-elektor.o
drivers/i2c/i2c-elv.o drivers/i2c/i2c-proc.o drivers/i2c/i2c-velleman.o
drivers/i2c/chips/lm75.o drivers/char/watchdog/softdog.o
drivers/char/watchdog/wdt.o drivers/char/watchdog/wdt_pci.o
*** Warning: "DBG_DECLARATIONS" [/usr/src/vpnclient/cisco_ipsec] is
COMMON symbol
*** Warning: "WorkSpaceList" [/usr/src/vpnclient/cisco_ipsec] is COMMON
symbol
*** Warning: "AIT_ECAcceleratorTablePointer"
[/usr/src/vpnclient/cisco_ipsec] is COMMON symbol
*** Warning: "ipc_response_size" [/usr/src/vpnclient/cisco_ipsec] is
COMMON symbol
*** Warning: "BindingArray" [/usr/src/vpnclient/cisco_ipsec] is COMMON
symbol
*** Warning: "tcp_ctl_ports" [/usr/src/vpnclient/cisco_ipsec] is COMMON
symbol
*** Warning: "TotalBindings" [/usr/src/vpnclient/cisco_ipsec] is COMMON
symbol
*** Warning: "ips" [/usr/src/vpnclient/cisco_ipsec] is COMMON symbol
*** Warning: "AIT_INIT_VECTOR" [/usr/src/vpnclient/cisco_ipsec] is
COMMON symbol
*** Warning: "split_dns_query_cache" [/usr/src/vpnclient/cisco_ipsec] is
COMMON symbol
*** Warning: "split_dns_domains" [/usr/src/vpnclient/cisco_ipsec] is
COMMON symbol
*** Warning: "g_MacHeader" [/usr/src/vpnclient/cisco_ipsec] is COMMON
symbol
*** Warning: "ipc_response_data" [/usr/src/vpnclient/cisco_ipsec] is
COMMON symbol
*** Warning: "split_dns_addrs" [/usr/src/vpnclient/cisco_ipsec] is
COMMON symbol
*** Warning: "config_data" [/usr/src/vpnclient/cisco_ipsec] is COMMON
symbol
make: Leaving directory `/usr/src/linux-2.5.64'
