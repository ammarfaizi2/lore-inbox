Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261470AbTCGKX4>; Fri, 7 Mar 2003 05:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261482AbTCGKX4>; Fri, 7 Mar 2003 05:23:56 -0500
Received: from mailout09.sul.t-online.com ([194.25.134.84]:42696 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261470AbTCGKXy>; Fri, 7 Mar 2003 05:23:54 -0500
Message-Id: <4.3.2.7.2.20030307111025.00b6c100@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Fri, 07 Mar 2003 11:13:47 +0100
To: linux-kernel@vger.kernel.org
From: margitsw@t-online.de (Margit Schubert-While)
Subject: Re: Linux 2.4.21pre5-ac2
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Warnings from make.

	Margit

  -c -o pci-pc.o pci-pc.c
{standard input}: Assembler messages:
{standard input}:980: Warning: indirect lcall without `*'
{standard input}:1056: Warning: indirect lcall without `*'
{standard input}:1138: Warning: indirect lcall without `*'
{standard input}:1214: Warning: indirect lcall without `*'
{standard input}:1230: Warning: indirect lcall without `*'
{standard input}:1240: Warning: indirect lcall without `*'
{standard input}:1306: Warning: indirect lcall without `*'
{standard input}:1321: Warning: indirect lcall without `*'
{standard input}:1332: Warning: indirect lcall without `*'
{standard input}:1801: Warning: indirect lcall without `*'
{standard input}:1876: Warning: indirect lcall without `*'

  -o apm.o apm.c
{standard input}: Assembler messages:
{standard input}:244: Warning: indirect lcall without `*'
{standard input}:336: Warning: indirect lcall without `*'

as -o bbootsect.o bbootsect.s
bbootsect.s: Assembler messages:
bbootsect.s:256: Warning: indirect lcall without `*'

as -o bsetup.o bsetup.s
bsetup.s: Assembler messages:
bsetup.s:1748: Warning: value 0x37ffffff truncated to 0x37ffffff
bsetup.s:2141: Warning: indirect lcall without `*'

=isdn_ppp  -c -o isdn_ppp.o isdn_ppp.c
isdn_ppp.c: In function `isdn_ppp_free':
isdn_ppp.c:111: warning: concatenation of string literals with __FUNCTION__ 
is deprecated
isdn_ppp.c:131: warning: concatenation of string literals with __FUNCTION__ 
is deprecated
isdn_ppp.c: In function `isdn_ppp_wakeup_daemon':
isdn_ppp.c:232: warning: concatenation of string literals with __FUNCTION__ 
is deprecated
isdn_ppp.c: In function `isdn_ppp_closewait':
isdn_ppp.c:251: warning: concatenation of string literals with __FUNCTION__ 
is deprecated
isdn_ppp.c: In function `isdn_ppp_release':
isdn_ppp.c:347: warning: concatenation of string literals with __FUNCTION__ 
is deprecated
isdn_ppp.c:357: warning: concatenation of string literals with __FUNCTION__ 
is deprecated
isdn_ppp.c: In function `isdn_ppp_push_higher':
isdn_ppp.c:1029: warning: concatenation of string literals with 
__FUNCTION__ is deprecated
isdn_ppp.c:1055: warning: concatenation of string literals with 
__FUNCTION__ is deprecated
isdn_ppp.c: In function `isdn_ppp_receive_ccp':
isdn_ppp.c:2494: warning: concatenation of string literals with 
__FUNCTION__ is deprecated
isdn_ppp.c:2504: warning: concatenation of string literals with 
__FUNCTION__ is deprecated
isdn_ppp.c: In function `isdn_ppp_send_ccp':
isdn_ppp.c:2668: warning: concatenation of string literals with 
__FUNCTION__ is deprecated
isdn_ppp.c:2691: warning: concatenation of string literals with 
__FUNCTION__ is deprecated

=cpia  -DEXPORT_SYMTAB -c cpia.c
cpia.c: In function `proc_cpia_create':
cpia.c:1334: warning: concatenation of string literals with __FUNCTION__ is 
deprecated
cpia.c: In function `set_vw_size':
cpia.c:1539: warning: concatenation of string literals with __FUNCTION__ is 
deprecated
cpia.c: In function `parse_picture':
cpia.c:1912: warning: concatenation of string literals with __FUNCTION__ is 
deprecated
cpia.c:1918: warning: concatenation of string literals with __FUNCTION__ is 
deprecated
cpia.c:1924: warning: concatenation of string literals with __FUNCTION__ is 
deprecated
cpia.c:1930: warning: concatenation of string literals with __FUNCTION__ is 
deprecated
cpia.c:1949: warning: concatenation of string literals with __FUNCTION__ is 
deprecated
cpia.c:1956: warning: concatenation of string literals with __FUNCTION__ is 
deprecated

=cpia_pp  -c -o cpia_pp.o cpia_pp.c
cpia_pp.c: In function `cpia_pp_register':
cpia_pp.c:486: warning: concatenation of string literals with __FUNCTION__ 
is deprecated
cpia_pp.c:492: warning: concatenation of string literals with __FUNCTION__ 
is deprecated
cpia_pp.c:501: warning: concatenation of string literals with __FUNCTION__ 
is deprecated
cpia_pp.c:514: warning: concatenation of string literals with __FUNCTION__ 
is deprecated
cpia_pp.c: In function `cpia_pp_init':
cpia_pp.c:606: warning: concatenation of string literals with __FUNCTION__ 
is deprecated
cpia_pp.c: In function `init_module':
cpia_pp.c:630: warning: concatenation of string literals with __FUNCTION__ 
is deprecated

=ip_nat_helper  -c -o ip_nat_helper.o ip_nat_helper.c
ip_nat_helper.c: In function `ip_nat_resize_packet':
ip_nat_helper.c:87: warning: unused variable `data'
ip_nat_helper.c: In function `ip_nat_helper_register':
ip_nat_helper.c:498: warning: concatenation of string literals with 
__FUNCTION__ is deprecated
ip_nat_helper.c: In function `ip_nat_helper_unregister':
ip_nat_helper.c:582: warning: concatenation of string literals with 
__FUNCTION__ is deprecated

drv  -c -o radeon_drv.o radeon_drv.c
In file included from drmP.h:75,
                  from radeon_drv.c:32:
drm_os_linux.h:16:2: warning: #warning the author of this code needs to 
read up on list_entry
In file included from radeon_drv.c:35:
radeon_drv.h:846:2: warning: #warning PCI posting bug
In file included from drm_dma.h:33,
                  from radeon_drv.c:42:
drm_os_linux.h:16:2: warning: #warning the author of this code needs to 
read up on list_entry

