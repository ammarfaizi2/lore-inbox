Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264963AbTAJNye>; Fri, 10 Jan 2003 08:54:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265008AbTAJNye>; Fri, 10 Jan 2003 08:54:34 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:6384 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S264963AbTAJNye>; Fri, 10 Jan 2003 08:54:34 -0500
Date: Fri, 10 Jan 2003 15:03:13 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, support@moxa.com.tw
Subject: 2.5.55: static compilation of mxser.c doesn't work
Message-ID: <20030110140313.GL6626@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

the 2.5 Linux kernel contains your patch

   o mxser: add module_exit/module_init
   This fixes the compilation problem in 2.5

This patch renames mxser_init to mxser_module_init causing a compile 
error when trying to compile this driver statically into the kernel 
since mxser_init is still called from drivers/char/tty_io.c.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

