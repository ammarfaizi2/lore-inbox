Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261630AbUBVA2b (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 19:28:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261632AbUBVA2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 19:28:31 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:41883
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S261630AbUBVA23
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 19:28:29 -0500
Date: Sat, 21 Feb 2004 19:38:48 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.2 on supermicro x5da8
Message-ID: <20040221193848.A25069@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've had some major problems with all 2.6 kernels <= 2.6.2 (not tried any
newer) and this board.  It has an intel e7505 chipset.  I can easily make it
not work by reading a bad cdrom in my first drive (it's an optorite dvd
burner).  This drive is hda (The hard disks are scsi).  Once it hits an
error, hda is now useless and I have to shutdown the machine.  I've also had
problems with the USB on this system as well.  Same thing, once an error
happens, usb is useless.

Does linux not support this chipset very well?  Everything else works fine. 
All scsi devices behave normally, network is fine (intel e1000 and 3com
3c900 tpc), sound is fine.  It's just the IDE and USB that causes problems. 

I noticed that after hda hung, the system hung 5 minutes later.  I never see
anything in dmesg when this happens.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
