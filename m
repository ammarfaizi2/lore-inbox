Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316753AbSFDUkB>; Tue, 4 Jun 2002 16:40:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316755AbSFDUkA>; Tue, 4 Jun 2002 16:40:00 -0400
Received: from mx2.fuse.net ([216.68.1.120]:59338 "EHLO mta02.fuse.net")
	by vger.kernel.org with ESMTP id <S316753AbSFDUj7>;
	Tue, 4 Jun 2002 16:39:59 -0400
Message-ID: <3CFD25B7.2090108@fuse.net>
Date: Tue, 04 Jun 2002 16:40:23 -0400
From: Nathan <wfilardo@fuse.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020520 Debian/1.0rc2-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.20-dj2 : "Duplicate initializer" in drivers/scsi/aic7xxx/aic7xxx_linux.c
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc -D__KERNEL__ -I/home/wes/src/kernel/linux-2.5.20/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 
-malign-functions=4     -DKBUILD_BASENAME=aic7xxx_linux  -c -o 
aic7xxx_linux.o aic7xxx_linux.c
aic7xxx_linux.c:2829: unknown field `abort' specified in initializer
aic7xxx_linux.c:2829: unknown field `reset' specified in initializer
aic7xxx_linux.c:2829: duplicate initializer
aic7xxx_linux.c:2829: (near initialization for 
`driver_template.slave_attach')
aic7xxx_linux.c:2829: duplicate initializer
aic7xxx_linux.c:2829: (near initialization for `driver_template.bios_param')
make[3]: *** [aic7xxx_linux.o] Error 1

Erhm, what's that mean? ^_^  And more importantly, how does one fix that?

--Nathan


