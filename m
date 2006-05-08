Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932415AbWEHQzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415AbWEHQzE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 12:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932422AbWEHQzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 12:55:04 -0400
Received: from tartu.cyber.ee ([193.40.6.68]:50692 "EHLO tartu.cyber.ee")
	by vger.kernel.org with ESMTP id S932415AbWEHQzD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 12:55:03 -0400
From: Meelis Roos <mroos@linux.ee>
To: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: libata PATA patch update
In-Reply-To: <1147104400.3172.7.camel@localhost.localdomain>
User-Agent: tin/1.8.2-20060425 ("Shillay") (UNIX) (Linux/2.6.17-rc2-g454ac778-dirty (i686))
Message-Id: <20060508165459.F1083146C4@rhn.tartu-labor>
Date: Mon,  8 May 2006 19:54:59 +0300 (EEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

AC> I've posted a new patch versus 2.6.17-rc3 up at the usual location.

pata_cs5535 doesn't compile at all:

  CC      drivers/scsi/pata_artop.o
drivers/scsi/pata_artop.c: In function 'artop_init_one':
drivers/scsi/pata_artop.c:433: warning: 'info' may be used uninitialized in this function
  CC      drivers/scsi/pata_atiixp.o
drivers/scsi/pata_atiixp.c: In function 'atiixp_set_dmamode':
drivers/scsi/pata_atiixp.c:122: warning: 'wanted_pio' may be used uninitialized in this function
  CC      drivers/scsi/pata_cmd64x.o
  CC      drivers/scsi/pata_cs5520.o
  CC      drivers/scsi/pata_cs5530.o
  CC      drivers/scsi/pata_cs5535.o
drivers/scsi/pata_cs5535.c: In function 'cs5535_probe_reset':
drivers/scsi/pata_cs5535.c:102: error: 'cs5535p_probe_init' undeclared (first use in this function)
drivers/scsi/pata_cs5535.c:102: error: (Each undeclared identifier is reported only once
drivers/scsi/pata_cs5535.c:102: error: for each function it appears in.)
make[2]: *** [drivers/scsi/pata_cs5535.o] Error 1

-- 
Meelis Roos
