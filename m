Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261561AbSLCWB6>; Tue, 3 Dec 2002 17:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261664AbSLCWB6>; Tue, 3 Dec 2002 17:01:58 -0500
Received: from dhcp80ff2399.dynamic.uiowa.edu ([128.255.35.153]:12424 "EHLO
	localhost") by vger.kernel.org with ESMTP id <S261561AbSLCWB5>;
	Tue, 3 Dec 2002 17:01:57 -0500
Date: Tue, 3 Dec 2002 16:09:28 -0600
From: Joseph Pingenot <trelane@digitasaru.net>
To: linux-kernel@vger.kernel.org
Subject: [ide-scsi] "structure has no member named `tag'"
Message-ID: <20021203220928.GA3024@digitasaru.net>
Reply-To: trelane@digitasaru.net
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-School: University of Iowa
X-vi-or-emacs: vi *and* emacs!
X-MSMail-Priority: High
X-Priority: 1 (Highest)
X-MS-TNEF-Correlator: <AFJAUFHRUOGRESULWAOIHFEAUIOFBVHSHNRAIU.monkey@spamcentral.invalid>
X-MimeOLE: Not Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Found this on 2.5.50+bk3

  gcc -Wp,-MD,drivers/scsi/.ide-scsi.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=k6 -Iarch/i386/mach-generic -nostdinc -iwithprefix include -DMODULE   -DKBUILD_BASENAME=ide_scsi -DKBUILD_MODNAME=ide_scsi   -c -o drivers/scsi/ide-scsi.o drivers/scsi/ide-scsi.c
drivers/scsi/ide-scsi.c: In function `should_transform':
drivers/scsi/ide-scsi.c:767: structure has no member named `tag'
make[2]: *** [drivers/scsi/ide-scsi.o] Error 1
make[1]: *** [drivers/scsi] Error 2
make: *** [drivers] Error 2


-- 
Joseph===============================================trelane@digitasaru.net
"I use Linux and it makes me feel safer knowing exactly what security
 problems my boxen are facing. If I wanted filtered information or a public
 relations a** kissing, I'd use Microsoft products." --dattaway, on /.
