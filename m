Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130317AbRCTObb>; Tue, 20 Mar 2001 09:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130380AbRCTObV>; Tue, 20 Mar 2001 09:31:21 -0500
Received: from jalon.able.es ([212.97.163.2]:64166 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S130317AbRCTObM>;
	Tue, 20 Mar 2001 09:31:12 -0500
Date: Tue, 20 Mar 2001 15:30:11 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Igor Mozetic <igor.mozetic@uni-mb.si>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Anybody C440GX+ aic7xxx SMP ?
Message-ID: <20010320153011.A1484@werewolf.able.es>
In-Reply-To: <15031.26020.148149.238240@ravan.camtp.uni-mb.si>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <15031.26020.148149.238240@ravan.camtp.uni-mb.si>; from igor.mozetic@uni-mb.si on Tue, Mar 20, 2001 at 15:13:56 +0100
X-Mailer: Balsa 1.1.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 03.20 Igor Mozetic wrote:
> We plan to buy a second Xeon 550Mhz for the C440GX+ board.
> Before we invest 1300$ I would like to hear if anybody is
> running 2.4.x on this hardware without problems. 
> On a UP box with 2GB RAM, I run 2.4.3-pre3 + Gibbs' aic7xxx-6.1.7
> + stock eepro100. Anybody with SMP ?
> 

If it is usefull for you, I'm running a SuperMicro P6DGU (400GX):

00:00.0 Host bridge: Intel Corporation 440GX - 82443GX Host bridge
00:01.0 PCI bridge: Intel Corporation 440GX - 82443GX AGP bridge
00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
00:0e.0 SCSI storage controller: Adaptec AHA-2940U2/W / 7890 (rev 01)

with 2xPII@400, 256Mb RAM. Bios version 3.1.

With 2.4.2-ac20+aic6.1.7. Just took away the scsi/aic7xxx from ac20 and
put instead the Gibbs version.

No problem.

-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.2-ac20 #2 SMP Tue Mar 13 15:49:10 CET 2001 i686

