Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312570AbSDSUse>; Fri, 19 Apr 2002 16:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312889AbSDSUsd>; Fri, 19 Apr 2002 16:48:33 -0400
Received: from mpdr0.chicago.il.ameritech.net ([67.38.100.19]:487 "EHLO
	mailhost.chi.ameritech.net") by vger.kernel.org with ESMTP
	id <S312570AbSDSUsd>; Fri, 19 Apr 2002 16:48:33 -0400
Message-ID: <3CC08373.4090708@ameritech.net>
Date: Fri, 19 Apr 2002 15:52:03 -0500
From: watermodem <aquamodem@ameritech.net>
Reply-To: aquamodem@ameritech.net
Organization: not at all
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
CC: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19pre7-ac1
In-Reply-To: <200204190916.g3J9G0b01318@devserv.devel.redhat.com> <3CC0790F.2070400@ameritech.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Trying again with menuconfig the compile fails..


         net/network.o \
         /usr/src/linux-2.4.19-pre7-ac1/arch/i386/lib/lib.a 
/usr/src/linux-2.4.1
1/lib/lib.a /usr/src/linux-2.4.19-pre7-ac1/arch/i386/lib/lib.a \
         --end-group \
         -o vmlinux
init/main.o: In function `smp_init':
init/main.o(.text.init+0x5f1): undefined reference to `skip_ioapic_setup'
arch/i386/kernel/kernel.o: In function `broken_pirq':
arch/i386/kernel/kernel.o(.text.init+0x350b): undefined reference to 
`skip_ioap
make: *** [vmlinux] Error 1

