Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265353AbUBBL1Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 06:27:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265359AbUBBL1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 06:27:16 -0500
Received: from alpha.zarz.agh.edu.pl ([149.156.122.231]:18950 "EHLO
	alpha.zarz.agh.edu.pl") by vger.kernel.org with ESMTP
	id S265353AbUBBL1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 06:27:11 -0500
Date: Mon, 2 Feb 2004 13:24:16 +0100 (CET)
From: "Wojciech 'Sas' Cieciwa" <cieciwa@alpha.zarz.agh.edu.pl>
To: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
Cc: linux-parport@torque.net, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PARPORT: C99 Initializers
In-Reply-To: <20040201.233544.76262593.yoshfuji@linux-ipv6.org>
Message-ID: <Pine.LNX.4.58L.0402021322410.10419@alpha.zarz.agh.edu.pl>
References: <20040201.224431.17604798.yoshfuji@linux-ipv6.org>
 <20040201.225619.67854403.yoshfuji@linux-ipv6.org>
 <20040201.233544.76262593.yoshfuji@linux-ipv6.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Feb 2004, YOSHIFUJI Hideaki / ???? wrote:

> In article <20040201.225619.67854403.yoshfuji@linux-ipv6.org> (at Sun, 01 Feb 2004 22:56:19 +0900 (JST)), YOSHIFUJI Hideaki / ???? <yoshfuji@linux-ipv6.org> says:
> 
> > Please use this instead.
> 
> Hmm... take 3...
> (I don't understand why I didn't get errors while compiling before...)
[...]

Applayed on AMD64.
linux-2.6.2-rc3 + cset-200402_0305
And:
make[1]: `arch/x86_64/kernel/asm-offsets.s' is up to date.
  CHK     include/linux/compile.h
  CC [M]  drivers/parport/procfs.o
drivers/parport/procfs.c:366: error: parse error before '(' token
drivers/parport/procfs.c:372: error: parse error before '(' token
drivers/parport/procfs.c:378: error: parse error before '(' token
drivers/parport/procfs.c:410: error: `ctl_name' undeclared here (not in a function)
drivers/parport/procfs.c:410: error: initializer element is not constant
drivers/parport/procfs.c:410: error: (near initialization for `parport_device_sysctl_template.vars[1].ctl_name')
drivers/parport/procfs.c:411: error: initializer element is not constant
drivers/parport/procfs.c:411: error: (near initialization for `parport_device_sysctl_template.vars[1]')
drivers/parport/procfs.c:412: error: initializer element is not constant
drivers/parport/procfs.c:412: error: (near initialization for `parport_device_sysctl_template.vars')
drivers/parport/procfs.c:416: error: initializer element is not constant
drivers/parport/procfs.c:416: error: (near initialization for `parport_device_sysctl_template.device_dir[0]')
drivers/parport/procfs.c:419: error: initializer element is not constant
drivers/parport/procfs.c:419: error: (near initialization for `parport_device_sysctl_template.device_dir[1]')
drivers/parport/procfs.c:420: error: initializer element is not constant
drivers/parport/procfs.c:420: error: (near initialization for `parport_device_sysctl_template.device_dir')
drivers/parport/procfs.c:422: error: initializer element is not constant
drivers/parport/procfs.c:422: error: (near initialization for `parport_device_sysctl_template.devices_root_dir[0]')
drivers/parport/procfs.c:425: error: initializer element is not constant
drivers/parport/procfs.c:425: error: (near initialization for `parport_device_sysctl_template.devices_root_dir[1]')
drivers/parport/procfs.c:426: error: initializer element is not constant
drivers/parport/procfs.c:426: error: (near initialization for `parport_device_sysctl_template.devices_root_dir')
drivers/parport/procfs.c:428: error: parse error before '(' token
drivers/parport/procfs.c:428: error: initializer element is not constant
drivers/parport/procfs.c:428: error: (near initialization for `parport_device_sysctl_template.port_dir[0]')
drivers/parport/procfs.c:431: error: initializer element is not constant
drivers/parport/procfs.c:431: error: (near initialization for `parport_device_sysctl_template.port_dir[1]')
drivers/parport/procfs.c:432: error: initializer element is not constant
drivers/parport/procfs.c:432: error: (near initialization for `parport_device_sysctl_template.port_dir')
drivers/parport/procfs.c:434: error: parse error before '(' token
drivers/parport/procfs.c:434: error: initializer element is not constant
drivers/parport/procfs.c:434: error: (near initialization for `parport_device_sysctl_template.parport_dir[0]')
drivers/parport/procfs.c:437: error: initializer element is not constant
drivers/parport/procfs.c:437: error: (near initialization for `parport_device_sysctl_template.parport_dir[1]')
drivers/parport/procfs.c:438: error: initializer element is not constant
drivers/parport/procfs.c:438: error: (near initialization for `parport_device_sysctl_template.parport_dir')
drivers/parport/procfs.c:440: error: parse error before '(' token
drivers/parport/procfs.c:440: error: initializer element is not constant
drivers/parport/procfs.c:440: error: (near initialization for `parport_device_sysctl_template.dev_dir[0]')
drivers/parport/procfs.c:443: error: initializer element is not constant
drivers/parport/procfs.c:443: error: (near initialization for `parport_device_sysctl_template.dev_dir[1]')
drivers/parport/procfs.c:444: error: initializer element is not constant
drivers/parport/procfs.c:444: error: (near initialization for `parport_device_sysctl_template.dev_dir')
drivers/parport/procfs.c:466: error: wrong type argument to unary minus
drivers/parport/procfs.c:466: error: initializer element is not constant
drivers/parport/procfs.c:466: error: (near initialization for `parport_default_sysctl_table.vars[0].data')
drivers/parport/procfs.c:472: error: initializer element is not constant
drivers/parport/procfs.c:472: error: (near initialization for `parport_default_sysctl_table.vars[0]')
drivers/parport/procfs.c:482: error: initializer element is not constant
drivers/parport/procfs.c:482: error: (near initialization for `parport_default_sysctl_table.vars[1]')
drivers/parport/procfs.c:485: error: initializer element is not constant
drivers/parport/procfs.c:485: error: (near initialization for `parport_default_sysctl_table.vars[2]')
drivers/parport/procfs.c:486: error: initializer element is not constant
drivers/parport/procfs.c:486: error: (near initialization for `parport_default_sysctl_table.vars')
drivers/parport/procfs.c:492: warning: initialization from incompatible pointer type
drivers/parport/procfs.c:493: error: initializer element is not constant
drivers/parport/procfs.c:493: error: (near initialization for `parport_default_sysctl_table.default_dir[0]')
drivers/parport/procfs.c:496: error: initializer element is not constant
drivers/parport/procfs.c:496: error: (near initialization for `parport_default_sysctl_table.default_dir[1]')
drivers/parport/procfs.c:497: error: initializer element is not constant
drivers/parport/procfs.c:497: error: (near initialization for `parport_default_sysctl_table.default_dir')
drivers/parport/procfs.c:499: error: unknown field `parport_default_sysctl_table' specified in initializer
drivers/parport/procfs.c:499: error: initializer element is not constant
drivers/parport/procfs.c:499: error: (near initialization for `parport_default_sysctl_table.parport_dir[0]')
drivers/parport/procfs.c:502: error: initializer element is not constant
drivers/parport/procfs.c:502: error: (near initialization for `parport_default_sysctl_table.parport_dir[1]')
drivers/parport/procfs.c:503: error: initializer element is not constant
drivers/parport/procfs.c:503: error: (near initialization for `parport_default_sysctl_table.parport_dir')
drivers/parport/procfs.c:505: error: unknown field `parport_default_sysctl_table' specified in initializer
drivers/parport/procfs.c:505: error: initializer element is not constant
drivers/parport/procfs.c:505: error: (near initialization for `parport_default_sysctl_table.dev_dir[0]')
drivers/parport/procfs.c:508: error: initializer element is not constant
drivers/parport/procfs.c:508: error: (near initialization for `parport_default_sysctl_table.dev_dir[1]')
drivers/parport/procfs.c:509: error: initializer element is not constant
drivers/parport/procfs.c:509: error: (near initialization for `parport_default_sysctl_table.dev_dir')
make[2]: *** [drivers/parport/procfs.o] Error 1
make[1]: *** [drivers/parport] Error 2
make: *** [drivers] Error 2

-- 
{Wojciech 'Sas' Cieciwa}  {Member of PLD Team                               }
{e-mail: cieciwa@alpha.zarz.agh.edu.pl, http://www2.zarz.agh.edu.pl/~cieciwa}
