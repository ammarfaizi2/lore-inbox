Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263688AbUDGOro (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 10:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263698AbUDGOro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 10:47:44 -0400
Received: from mail0.epfl.ch ([128.178.50.57]:40712 "HELO mail0.epfl.ch")
	by vger.kernel.org with SMTP id S263688AbUDGOrk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 10:47:40 -0400
Date: Wed, 7 Apr 2004 16:47:38 +0200
From: Gregoire Favre <Gregoire.Favre@freesurf.ch>
To: linux-kernel@vger.kernel.org
Subject: 2.6.5-mm2 don't compil (sr)
Message-ID: <20040407144738.GA7822@magma.epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I got this:

  CC      drivers/scsi/sr.o
drivers/scsi/sr.c: In function `scsi_cd_get':
drivers/scsi/sr.c:128: error: structure has no member named `kobj'
drivers/scsi/sr.c: In function `scsi_cd_put':
drivers/scsi/sr.c:135: error: structure has no member named `kobj'
drivers/scsi/sr.c: In function `sr_probe':
drivers/scsi/sr.c:554: error: structure has no member named `kobj'
drivers/scsi/sr.c:555: error: structure has no member named `kobj'
drivers/scsi/sr.c: In function `sr_kobject_release':
drivers/scsi/sr.c:904: error: structure has no member named `kobj'
drivers/scsi/sr.c:904: warning: type defaults to `int' in declaration of `__mptr'
drivers/scsi/sr.c:904: warning: initialization from incompatible pointer type
drivers/scsi/sr.c:904: error: structure has no member named `kobj'
make[2]: *** [drivers/scsi/sr.o] Error 1
make[1]: *** [drivers/scsi] Error 2
make: *** [drivers] Error 2

2.6.5 compil just fine ;-)

	Grégoire
__________________________________________________________________________
http://algebra.epfl.ch/greg ICQ:16624071 mailto:Gregoire.Favre@freesurf.ch
