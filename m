Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315259AbSGMRjf>; Sat, 13 Jul 2002 13:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315265AbSGMRje>; Sat, 13 Jul 2002 13:39:34 -0400
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:3376 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S315259AbSGMRjd>; Sat, 13 Jul 2002 13:39:33 -0400
Date: Sat, 13 Jul 2002 19:26:27 +0200
From: Heinz Diehl <hd@cavy.de>
To: linux-kernel@vger.kernel.org
Cc: davej@codemonkey.org.uk
Subject: Re: Linux 2.5.25-dj2
Message-ID: <20020713172627.GA5606@chiara.cavy.de>
Mail-Followup-To: linux-kernel@vger.kernel.org, davej@codemonkey.org.uk
References: <20020712222454.GA10322@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020712222454.GA10322@suse.de>
Organization: private site in Mannheim/Germany
X-PGP-Key: Use PGP! Get my key at http://www.cavy.de/hd.key
User-Agent: Mutt/1.5.1i (Linux 2.4.19-rc1-dh1 i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Jul 12 2002, Dave Jones wrote:

[....]

  gcc -Wp,-MD,./.ide-scsi24.o.d -D__KERNEL__ -I/usr/src/linux/include
  -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
  -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2
  -march=k6 -nostdinc -iwithprefix include
  -DKBUILD_BASENAME=ide_scsi24-c -o ide-scsi24.o ide-scsi24.c
  ide-scsi24.c:847: unknown field abort' specified in initializer
  ide-scsi24.c:847: warning: initialization from incompatible pointer type
  ide-scsi24.c:848: unknown field reset' specified in initializer
  ide-scsi24.c:848: warning: initialization from incompatible pointer type
  make[3]: *** [ide-scsi24.o] Error 1
  make[3]: Leaving directory /usr/src/linux/drivers/scsi'
  make[2]: *** [scsi] Error 2
  make[2]: Leaving directory /usr/src/linux/drivers'
  make[1]: *** [drivers] Error 2
  make[1]: Leaving directory /usr/src/linux'
  make: *** [bzImage] Error 2
  chiara:/usr/src/linux #

-- 
# Heinz Diehl, 68259 Mannheim, Germany
