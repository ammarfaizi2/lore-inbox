Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293484AbSCKCPf>; Sun, 10 Mar 2002 21:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293485AbSCKCPQ>; Sun, 10 Mar 2002 21:15:16 -0500
Received: from h24-71-223-13.cg.shawcable.net ([24.71.223.13]:25937 "EHLO
	pd2mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id <S293484AbSCKCPM>; Sun, 10 Mar 2002 21:15:12 -0500
Date: Sun, 10 Mar 2002 18:14:57 -0800
From: Jack Bowling <jbinpg@shaw.ca>
Subject: initio scsi won't compile  in 2.5.6
In-Reply-To: <20020217173443.H28092@sunbeam.de.gnumonks.org>
To: Harald Welte <laforge@gnumonks.org>, lkm <linux-kernel@vger.kernel.org>
Reply-to: Jack Bowling <jbinpg@shaw.ca>
Message-id: <0GSS00EFLE8W1U@l-daemon>
MIME-version: 1.0
X-Mailer: The Polarbar Mailer; version=1.22prev2; build=1181
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
In-Reply-To: <3C6F946F.6030207@freesurf.fr>
 <20020217173443.H28092@sunbeam.de.gnumonks.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following output from an attempted compile of kernel 2.5.6 indicates to me that the initio scsi module has yet to be ported over to the new code. I am not a programmer so am just throwing it out there as something that would be nice to have done if I am eventually ever going to use 2.5.6 and beyond with my scsi hardware :-))

------------

gcc -D__KERNEL__ -I/usr/src/linux-2.5.6/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686   -DKBUILD_BASENAME=ini9100u  -c -o ini9100u.o ini9100u.c
ini9100u.c:111:2: #error Please convert me to Documentation/DMA-mapping.txt
ini9100u.c: In function `i91uBuildSCB':
ini9100u.c:494: structure has no member named `address'
ini9100u.c:503: structure has no member named `address'
make[3]: *** [ini9100u.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.5.6/drivers/scsi'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-2.5.6/drivers/scsi'
make[1]: *** [_subdir_scsi] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.6/drivers'
make: *** [_dir_drivers] Error 2

-------

jb

PS - please copy me on any replies. I am not subbed to lkml

--
Jack Bowling
mailto: jbinpg@shaw.ca
