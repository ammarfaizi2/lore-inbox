Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262574AbRE3CWv>; Tue, 29 May 2001 22:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262568AbRE3CWl>; Tue, 29 May 2001 22:22:41 -0400
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:59153 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S262574AbRE3CWg>; Tue, 29 May 2001 22:22:36 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Frank Davis <fdavis112@juno.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.5-ac4 es1371.o unresolved symbols 
In-Reply-To: Your message of "Tue, 29 May 2001 21:56:51 -0400."
             <381058575.991187817702.JavaMail.root@web649-wra> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 30 May 2001 12:22:29 +1000
Message-ID: <13865.991189349@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 May 2001 21:56:51 -0400 (EDT), 
Frank Davis <fdavis112@juno.com> wrote:
>     While 'make modules_install' on 2.4.5-ac4, I received the following error:
>depmod: *** Unresolved symbols in /lib/modules/2.4.5-ac4/kernel/drivers/sound/es1371.o
>depmod:  gameport_register_port_Rsmp_aa96bd99
>depmod:  gameport_unregister_port_Rsmp_ec101047

Need more info.
  cd 2.4.5-ac4
  grep 'gameport_.*register_port' /proc/ksyms System.map
  sed -ne '/^CONFIG/s/CONFIG_//p' .config

