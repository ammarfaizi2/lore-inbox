Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261274AbTCXXPM>; Mon, 24 Mar 2003 18:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263245AbTCXXPM>; Mon, 24 Mar 2003 18:15:12 -0500
Received: from mailrelay2.lanl.gov ([128.165.4.103]:54707 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP
	id <S261274AbTCXXPK>; Mon, 24 Mar 2003 18:15:10 -0500
Subject: Re: CONFIG_VT_CONSOLE in 2.5.6x ?
From: Steven Cole <elenstev@mesatop.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: louisg00@bellsouth.net, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <33453.4.64.238.61.1048547120.squirrel@www.osdl.org>
References: <1048546447.3058.3.camel@tiger> 
	<33453.4.64.238.61.1048547120.squirrel@www.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 24 Mar 2003 16:21:43 -0700
Message-Id: <1048548103.2464.78.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-03-24 at 16:05, Randy.Dunlap wrote:
> > I can't find CONFIG_VT_CONSOLE anywhere in menuconfig. I am having problems
> > not viewing the bootup messages on my monitor. I do have
> > console=tty0 in grub.conf.
> 
> It's the second line of the Character Devices menu:
> 
>   &#9474; &#9474;[*] Virtual terminal
>   &#9474; &#9474;[*]   Support for console on virtual terminal     <<<<<
> 
> ~Randy

If you can't get Randy to answer your question, here's another way to
find this out:
[steven@spc5 testing-2.5]$ find . -name Kconfig | xargs grep VT_CONSOLE
./arch/m68k/Kconfig:config VT_CONSOLE
./arch/mips/Kconfig:config VT_CONSOLE
./arch/mips/Kconfig:config VT_CONSOLE
./arch/sh/Kconfig:config VT_CONSOLE
./arch/sparc/Kconfig:config VT_CONSOLE
./arch/sparc64/Kconfig:config VT_CONSOLE
./drivers/char/Kconfig:config VT_CONSOLE
[steven@spc5 testing-2.5]$ uptime && uname -r
  4:05pm  up 23 min,  2 users,  load average: 103.78, 102.87, 58.59
2.5.66

Steven




