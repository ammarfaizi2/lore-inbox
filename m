Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964942AbWBGG7F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964942AbWBGG7F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 01:59:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964943AbWBGG7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 01:59:05 -0500
Received: from zproxy.gmail.com ([64.233.162.196]:45807 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964942AbWBGG7E convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 01:59:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=cUQpCAB1zF62A9tGO75+xyLOS9ltiZkV4tJQ6Ha9j/O3jXvRPcIsYQ8vooZM1tHZ1egTit0dVyrU4Cp0HPLWMEqqz4BWkIYoMa7hYYq8tq4qFDL4mo/GJfeUZuB57uZMD8pSTkPReZmrD3INdaDBgtaEnqCoLfrsAfbMsKGfKVs=
Message-ID: <1200c63a0602062259g5a6d0a28l93f207ef6d3f9485@mail.gmail.com>
Date: Tue, 7 Feb 2006 12:29:03 +0530
From: Vishal Sharma <vishal.gnutech@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Kernel-2.6.15 compile error
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

i am trying to install this new kenel into my machine with the option make
oldconfig , my old kernel is 2.6.11-1.1369_FC4smp and i am using
gcc-4.0.2.Below s the output of error  i am getting :-

GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
drivers/built-in.o(.text+0x94aea): In function `sandisk_set_iobase':
drivers/net/wireless/hostap/hostap_cs.c:242: undefined reference to
`pcmcia_access_configuration_register'
drivers/built-in.o(.text+0x94b27):drivers/net/wireless/hostap/hostap_cs.c:254:
undefined reference to `pcmcia_access_configuration_register'
drivers/built-in.o(.text+0x94c6b): In function `sandisk_enable_wireless':
drivers/net/wireless/hostap/hostap_cs.c:306: undefined reference to
`pcmcia_get_first_tuple'
drivers/built-in.o(.text+0x94c86):drivers/net/wireless/hostap/hostap_cs.c:306:
undefined reference to `pcmcia_get_tuple_data'
drivers/built-in.o(.text+0x94c99):drivers/net/wireless/hostap/hostap_cs.c:306:
undefined reference to `pcmcia_parse_tuple'
drivers/built-in.o(.text+0x94cb8):drivers/net/wireless/hostap/hostap_cs.c:316:
undefined reference to `pcmcia_get_first_tuple'
drivers/built-in.o(.text+0x94cc9):drivers/net/wireless/hostap/hostap_cs.c:316:
undefined reference to `pcmcia_get_tuple_data'
drivers/built-in.o(.text+0x94cdc):drivers/net/wireless/hostap/hostap_cs.c:316:
undefined reference to `pcmcia_parse_tuple'
drivers/built-in.o(.text+0x94d2b):drivers/net/wireless/hostap/hostap_cs.c:333:
undefined reference to `pcmcia_access_configuration_register'
drivers/built-in.o(.text+0x94d63):drivers/net/wireless/hostap/hostap_cs.c:350:
undefined reference to `pcmcia_access_configuration_register'
drivers/built-in.o(.text+0x94e2d): In function `prism2_pccard_cor_sreset':
drivers/net/wireless/hostap/hostap_cs.c:385: undefined reference to
`pcmcia_access_configuration_register'
drivers/built-in.o(.text+0x94e90):drivers/net/wireless/hostap/hostap_cs.c:397:
undefined reference to `pcmcia_access_configuration_register'
drivers/built-in.o(.text+0x94ee5):drivers/net/wireless/hostap/hostap_cs.c:410:
undefined reference to `pcmcia_access_configuration_register'
drivers/built-in.o(.text+0x94faa):drivers/net/wireless/hostap/hostap_cs.c:444:
more undefined references to `pcmcia_access_configuration_register'
follow
drivers/built-in.o(.text+0x951b7): In function `prism2_attach':
drivers/net/wireless/hostap/hostap_cs.c:528: undefined reference to
`pcmcia_register_client'
drivers/built-in.o(.text+0x951d4):drivers/net/wireless/hostap/hostap_cs.c:530:
undefined reference to `cs_error'
drivers/built-in.o(.text+0x95233): In function `prism2_detach':
drivers/net/wireless/hostap/hostap_cs.c:558: undefined reference to
`pcmcia_deregister_client'
drivers/built-in.o(.text+0x952ba):drivers/net/wireless/hostap/hostap_cs.c:561:
undefined reference to `cs_error'
drivers/built-in.o(.text+0x953ad): In function `prism2_config':
drivers/net/wireless/hostap/hostap_cs.c:627: undefined reference to
`pcmcia_get_first_tuple'
drivers/built-in.o(.text+0x953c5):drivers/net/wireless/hostap/hostap_cs.c:810:
undefined reference to `cs_error'
drivers/built-in.o(.text+0x9540d):drivers/net/wireless/hostap/hostap_cs.c:628:
undefined reference to `pcmcia_get_tuple_data'
drivers/built-in.o(.text+0x95426):drivers/net/wireless/hostap/hostap_cs.c:629:
undefined reference to `pcmcia_parse_tuple'
drivers/built-in.o(.text+0x95450):drivers/net/wireless/hostap/hostap_cs.c:633:
undefined reference to `pcmcia_get_configuration_info'
drivers/built-in.o(.text+0x954b4):drivers/net/wireless/hostap/hostap_cs.c:641:
undefined reference to `pcmcia_get_first_tuple'
drivers/built-in.o(.text+0x954df):drivers/net/wireless/hostap/hostap_cs.c:644:
undefined reference to `cs_error'
drivers/built-in.o(.text+0x954e9):drivers/net/wireless/hostap/hostap_cs.c:733:
undefined reference to `pcmcia_get_next_tuple'
drivers/built-in.o(.text+0x954fd):drivers/net/wireless/hostap/hostap_cs.c:644:
undefined reference to `pcmcia_get_tuple_data'
drivers/built-in.o(.text+0x95511):drivers/net/wireless/hostap/hostap_cs.c:646:
undefined reference to `pcmcia_parse_tuple'
drivers/built-in.o(.text+0x956c9):drivers/net/wireless/hostap/hostap_cs.c:726:
undefined reference to `pcmcia_request_io'
drivers/built-in.o(.text+0x956f2):drivers/net/wireless/hostap/hostap_cs.c:726:
undefined reference to `cs_error'
drivers/built-in.o(.text+0x95737):drivers/net/wireless/hostap/hostap_cs.c:646:
undefined reference to `cs_error'
drivers/built-in.o(.text+0x9585c):drivers/net/wireless/hostap/hostap_cs.c:761:
undefined reference to `pcmcia_request_irq'
drivers/built-in.o(.text+0x95876):drivers/net/wireless/hostap/hostap_cs.c:770:
undefined reference to `pcmcia_request_configuration'
drivers/built-in.o(.text+0x95a2d): In function `prism2_release':
drivers/net/wireless/hostap/hostap_cs.c:837: undefined reference to
`pcmcia_release_window'
drivers/built-in.o(.text+0x95a35):drivers/net/wireless/hostap/hostap_cs.c:838:
undefined reference to `pcmcia_release_configuration'
drivers/built-in.o(.text+0x95a4e):drivers/net/wireless/hostap/hostap_cs.c:842:
undefined reference to `pcmcia_release_irq'
drivers/built-in.o(.text+0x95a67):drivers/net/wireless/hostap/hostap_cs.c:840:
undefined reference to `pcmcia_release_io'
drivers/built-in.o(.text+0x95af2): In function `prism2_event':
drivers/net/wireless/hostap/hostap_cs.c:895: undefined reference to
`pcmcia_release_configuration'
drivers/built-in.o(.text+0x95b64):drivers/net/wireless/hostap/hostap_cs.c:907:
undefined reference to `pcmcia_request_configuration'
drivers/built-in.o(.init.text+0x84da): In function `init_prism2_pccard':
drivers/net/wireless/hostap/hostap_cs.c:995: undefined reference to
`pcmcia_register_driver'
drivers/built-in.o(.exit.text+0x559): In function `exit_prism2_pccard':
drivers/net/wireless/hostap/hostap_cs.c:1000: undefined reference to
`pcmcia_unregister_driver'
make: *** [.tmp_vmlinux1] Error 1

why i am getting this error? is it somehting related to gcc-4.0.2 ?

Please Help

Regards
Vishal
--
Bringing Freedom....Deploying GNU/LINUX....
