Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265279AbUATIsq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 03:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265311AbUATIsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 03:48:45 -0500
Received: from alpha.zarz.agh.edu.pl ([149.156.122.231]:30983 "EHLO
	alpha.zarz.agh.edu.pl") by vger.kernel.org with ESMTP
	id S265279AbUATIso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 03:48:44 -0500
Date: Tue, 20 Jan 2004 10:46:28 +0100 (CET)
From: "Wojciech 'Sas' Cieciwa" <cieciwa@alpha.zarz.agh.edu.pl>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [2.6.1 + cset-20040120_0206] AHA152X building error
Message-ID: <Pine.LNX.4.58L.0401201043380.3210@alpha.zarz.agh.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I try to build this kernel and got this error:
[...]
  LD [M]  drivers/scsi/pcmcia/aha152x_cs.o
drivers/scsi/pcmcia/aha152x_core.o(.init.text+0x0): In function `init_module':
: multiple definition of `init_module'
drivers/scsi/pcmcia/aha152x_stub.o(.init.text+0x0): first defined here
ld: Warning: size of symbol `init_module' changed from 22 in drivers/scsi/pcmcia/aha152x_stub.o to 1212 in drivers/scsi/pcmcia/aha152x_core.o
drivers/scsi/pcmcia/aha152x_core.o(.exit.text+0x0): In function `cleanup_module':
: multiple definition of `cleanup_module'
drivers/scsi/pcmcia/aha152x_stub.o(.exit.text+0x0): first defined here
ld: Warning: size of symbol `cleanup_module' changed from 51 in drivers/scsi/pcmcia/aha152x_stub.o to 69 in drivers/scsi/pcmcia/aha152x_core.o
make[3]: *** [drivers/scsi/pcmcia/aha152x_cs.o] Error 1
make[2]: *** [drivers/scsi/pcmcia] Error 2
make[1]: *** [drivers/scsi] Error 2
make: *** [drivers] Error 2
[...]

Thanx.
					Sas.
-- 
{Wojciech 'Sas' Cieciwa}  {Member of PLD Team                               }
{e-mail: cieciwa@alpha.zarz.agh.edu.pl, http://www2.zarz.agh.edu.pl/~cieciwa}
