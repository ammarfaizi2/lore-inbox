Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965015AbWBGLIr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965015AbWBGLIr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 06:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965019AbWBGLIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 06:08:46 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:31630 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S965015AbWBGLIq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 06:08:46 -0500
From: "Jiri Slaby" <xslaby@fi.muni.cz>
Date: Tue,  7 Feb 2006 12:08:43 +0100
In-reply-to: <1200c63a0602062259g5a6d0a28l93f207ef6d3f9485@mail.gmail.com>
To: Vishal Sharma <vishal.gnutech@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel-2.6.15 compile error
Message-Id: <20060207110842.A3C9B22B379@anxur.fi.muni.cz>
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: xslaby@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hello All,
>
>i am trying to install this new kenel into my machine with the option make
>oldconfig , my old kernel is 2.6.11-1.1369_FC4smp and i am using
>gcc-4.0.2.Below s the output of error  i am getting :-
>
>GEN     .version
>  CHK     include/linux/compile.h
>  UPD     include/linux/compile.h
>  CC      init/version.o
>  LD      init/built-in.o
>  LD      .tmp_vmlinux1
>drivers/built-in.o(.text+0x94aea): In function `sandisk_set_iobase':
>drivers/net/wireless/hostap/hostap_cs.c:242: undefined reference to
>`pcmcia_access_configuration_register'
>drivers/built-in.o(.text+0x94b27):drivers/net/wireless/hostap/hostap_cs.c:254:
>undefined reference to `pcmcia_access_configuration_register'
[snip]
>undefined reference to `pcmcia_request_configuration'
>drivers/built-in.o(.init.text+0x84da): In function `init_prism2_pccard':
>drivers/net/wireless/hostap/hostap_cs.c:995: undefined reference to
>`pcmcia_register_driver'
>drivers/built-in.o(.exit.text+0x559): In function `exit_prism2_pccard':
>drivers/net/wireless/hostap/hostap_cs.c:1000: undefined reference to
>`pcmcia_unregister_driver'
>make: *** [.tmp_vmlinux1] Error 1
>
>why i am getting this error? is it somehting related to gcc-4.0.2 ?
>
>Please Help
.config, please.

regards,
--
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
B67499670407CE62ACC8 22A032CC55C339D47A7E
