Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262606AbUEKJD6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262606AbUEKJD6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 05:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263232AbUEKJDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 05:03:11 -0400
Received: from web13907.mail.yahoo.com ([216.136.175.70]:18191 "HELO
	web13907.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262648AbUEKJAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 05:00:24 -0400
Message-ID: <20040511090018.60934.qmail@web13907.mail.yahoo.com>
X-RocketYMMF: knobi.rm
Date: Tue, 11 May 2004 02:00:18 -0700 (PDT)
From: Martin Knoblauch <knobi@knobisoft.de>
Reply-To: knobi@knobisoft.de
Subject: 2.6.6: Warning building tda1004x
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 just a small nuisance [to me], as I don not care myself about the dvb
stuff.

Martin


/scratch/linux-kernel/linux-2.6.6> make modules
  CHK     include/linux/version.h
make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
  CC [M]  drivers/media/dvb/frontends/dst.o
  CC [M]  drivers/media/dvb/frontends/stv0299.o
  CC [M]  drivers/media/dvb/frontends/alps_tdlb7.o
  CC [M]  drivers/media/dvb/frontends/alps_tdmb7.o
  CC [M]  drivers/media/dvb/frontends/at76c651.o
  CC [M]  drivers/media/dvb/frontends/cx24110.o
  CC [M]  drivers/media/dvb/frontends/grundig_29504-491.o
  CC [M]  drivers/media/dvb/frontends/grundig_29504-401.o
  CC [M]  drivers/media/dvb/frontends/mt312.o
  CC [M]  drivers/media/dvb/frontends/ves1820.o
  CC [M]  drivers/media/dvb/frontends/ves1x93.o
  CC [M]  drivers/media/dvb/frontends/tda1004x.o
  CC [M]  drivers/media/dvb/frontends/sp887x.o
  CC [M]  drivers/media/dvb/frontends/nxt6000.o
  Building modules, stage 2.
  MODPOST
*** Warning: "errno" [drivers/media/dvb/frontends/tda1004x.ko]
undefined!
  CC      drivers/media/dvb/frontends/alps_tdlb7.mod.o
  LD [M]  drivers/media/dvb/frontends/alps_tdlb7.ko
  CC      drivers/media/dvb/frontends/alps_tdmb7.mod.o
  LD [M]  drivers/media/dvb/frontends/alps_tdmb7.ko
  CC      drivers/media/dvb/frontends/at76c651.mod.o
  LD [M]  drivers/media/dvb/frontends/at76c651.ko
  CC      drivers/media/dvb/frontends/cx24110.mod.o
  LD [M]  drivers/media/dvb/frontends/cx24110.ko
  CC      drivers/media/dvb/frontends/dst.mod.o
  LD [M]  drivers/media/dvb/frontends/dst.ko
  CC      drivers/media/dvb/frontends/grundig_29504-401.mod.o
  LD [M]  drivers/media/dvb/frontends/grundig_29504-401.ko
  CC      drivers/media/dvb/frontends/grundig_29504-491.mod.o
  LD [M]  drivers/media/dvb/frontends/grundig_29504-491.ko
  CC      drivers/media/dvb/frontends/mt312.mod.o
  LD [M]  drivers/media/dvb/frontends/mt312.ko
  CC      drivers/media/dvb/frontends/nxt6000.mod.o
  LD [M]  drivers/media/dvb/frontends/nxt6000.ko
  CC      drivers/media/dvb/frontends/sp887x.mod.o
  LD [M]  drivers/media/dvb/frontends/sp887x.ko
  CC      drivers/media/dvb/frontends/stv0299.mod.o
  LD [M]  drivers/media/dvb/frontends/stv0299.ko
  CC      drivers/media/dvb/frontends/tda1004x.mod.o
  LD [M]  drivers/media/dvb/frontends/tda1004x.ko
  CC      drivers/media/dvb/frontends/ves1820.mod.o
  LD [M]  drivers/media/dvb/frontends/ves1820.ko
  CC      drivers/media/dvb/frontends/ves1x93.mod.o
  LD [M]  drivers/media/dvb/frontends/ves1x93.ko


=====
------------------------------------------------------
Martin Knoblauch
email: k n o b i AT knobisoft DOT de
www:   http://www.knobisoft.de
