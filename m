Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132655AbREEPIg>; Sat, 5 May 2001 11:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132682AbREEPI0>; Sat, 5 May 2001 11:08:26 -0400
Received: from mailgate.FH-Aachen.DE ([149.201.10.254]:54181 "EHLO
	mailgate.fh-aachen.de") by vger.kernel.org with ESMTP
	id <S132655AbREEPIS>; Sat, 5 May 2001 11:08:18 -0400
Posted-Date: Sat, 5 May 2001 17:08:16 +0200 (MET DST)
Date: Sat, 5 May 2001 17:07:48 +0200
From: f5ibh <f5ibh@db0bm.ampr.org>
Message-Id: <200105051507.RAA29332@db0bm.ampr.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.5-pre1 errors with make menuconfig
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

If I do a make distclean then make menuconfig, I get the following error
message on the "Processor type and features  --->" entry (maybe a bit
corrupted because I had to do a ctrl_c to avoid the curses display to
owerwrite it). The other entries seems to be ok :

scripts/Menuconfig: CONFIG_M386: command not found
scripts/Menuconfig: ./MCradiolists: line 2: syntax error near unexpected token
`Pentium-III/Celeron(C'
scripts/Menuconfig: ./MCradiolists: line 2: `   function CONFIG_M386 ()
{ l_choice 'Processor family' "386
CONFIG_M386      486                                    CONFIG_M486
586/K5/5x86/6x86/6x86MX                CONFIG_M586      Pentium-Classic
CONFIG_M586TSC    Pentium-MMX                            CONFIG_M586MMX
Pentium-Pro/Celeron/Pentium-II         CONFIG_M686
Pentium-III/Celeron(Coppermine)CONFIG_MPENTIUMIII       Pentium-4
CONFIG_MPENTIUM4         K6/K6-II/K6-III                        CONFIG_MK6
Athlon/Duron/K7CONFIG_MK7       Crusoe
CONFIG_MCRUSOE   Winchip-C6                             CONFIG_MWINCHIPC6
Winchip-2             CONFIG_MWINCHIP2          Winchip-2A/Winchip-3
CONFIG_MWINCHIP3D        CyrixIII/C3
CONFIG_MCYRIXIII" Pentium-III/Celeron(Coppermine) ;}'
make: *** [menuconfig] Erreur 1

If I load a previous configuration from 2.4.4, it is ok
----------
Regards

		Jean-Luc
