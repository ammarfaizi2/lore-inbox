Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264664AbSJ3L1A>; Wed, 30 Oct 2002 06:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264667AbSJ3L1A>; Wed, 30 Oct 2002 06:27:00 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:16894 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S264664AbSJ3L07>; Wed, 30 Oct 2002 06:26:59 -0500
Date: Wed, 30 Oct 2002 12:33:19 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
cc: linux-kernel@vger.kernel.org
Subject: 2.4.20-rc1: Compile error in aicasm_gram.y with bison-1.75
Message-ID: <Pine.NEB.4.44.0210301230200.19481-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Justin,

with bison-1.75 I see the following compile error:

<--  snip  -->

...
make[5]: Entering directory
`/home/bunk/linux/kernel-2.4/linux-2.4.19-full/drivers/scsi/aic7xxx/aicasm'
yacc -d -b aicasm_gram aicasm_gram.y
aicasm_gram.y:921.21: parse error, unexpected ":", expecting ";" or "|"
aicasm_gram.y:936.2-5: $$ of `critical_section_start' has no declared type
aicasm_gram.y:938.2-5: $$ of `critical_section_start' has no declared type
make[5]: *** [aicasm_gram.h] Error 1
make[5]: Leaving directory
`/home/bunk/linux/kernel-2.4/linux-2.4.19-full/drivers/scsi/aic7xxx/aicasm'

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed




