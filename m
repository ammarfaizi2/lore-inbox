Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267345AbTAOVZC>; Wed, 15 Jan 2003 16:25:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267351AbTAOVZC>; Wed, 15 Jan 2003 16:25:02 -0500
Received: from pa186.opole.sdi.tpnet.pl ([213.76.204.186]:52725 "EHLO
	deimos.one.pl") by vger.kernel.org with ESMTP id <S267345AbTAOVZB> convert rfc822-to-8bit;
	Wed, 15 Jan 2003 16:25:01 -0500
Date: Wed, 15 Jan 2003 22:33:56 +0100
From: Damian =?iso-8859-2?Q?Ko=B3kowski?= <deimos@deimos.one.pl>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [BUG] 2.5.5{7,8} QM_MODULES: Function not implemented...
Message-ID: <20030115213356.GA176@deimos.one.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.4i
X-GPG: http://deimos.one.pl/deimos.asc
X-Age: 23 (1980.09.27 - lilbra)
X-JID: deimos@jabber.gda.pl
X-ICQ: 59367544
X-GG: 88988
X-Girl: 1 will be enough!
X-OS: GNU/Linux-2.4.20-ac2 (i686)
X-Uptime: 22:14:35  up 2 min,  1 user,  load average: 0.02, 0.03, 0.01
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After copiling kernel 2.5.5{7,8} and make modules_install I have:

depmod: *** Unresolved symbols in /lib/modules/2.5.58/kernel/arch/i386/kernel/apm.ko
depmod:         pm_power_off
depmod:         __sysrq_unlock_table
depmod:         get_cmos_time
depmod:         schedule_timeout
depmod:         misc_deregister
depmod:         __wake_up
depmod:         __sysrq_get_key_op
depmod:         __copy_to_user_ll
depmod:         schedule
[...]
	
in all modules.

As I remember something like this was in 2.4.19...

P.S. The modules are instaled but they could not be loaded.

-- 
# Damian *dEiMoS* Ko³kowski # http://deimos.one.pl/ #
