Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263483AbUDBBPP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 20:15:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263479AbUDBBPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 20:15:15 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:43656
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S263505AbUDBBOr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 20:14:47 -0500
Date: Thu, 1 Apr 2004 20:25:00 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: linux-kernel@vger.kernel.org
Subject: Slow network.
Message-ID: <20040401202500.A16167@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm looking for some pointers as to why this is happening.

I have a machine with 2.4.25/2.6.4 (boots over network) that serves 2 hard
disks to my network.

It has a microstar ms-6163 systemboard (I think that's the right number), a
160gb maxtor as hda.  hda contains an ext3 filesystem.  Nic is a 3c905b with
MBA.  256mb memory.  700mhz (100fsb) pIII.

Reading a 2.9gb file off hda is took 1:51 minutes (~26mb/sec).
When I do this over nfs, it takes over 8 minutes (~5.7mb/sec).

I used to get around 11mb/sec transfer from this machine.  The changes I
made was a different board/cpu/memory/kernel version and used an 80wire ide
cable for hda.  The nic is the same, hda is the same.

The old machine was a celeron 333a, 40wire ide cable, 192mb ram.  I don't
know what the board model was.  With the old board, I saw about 32mb/sec on
the same file (local) and 11mb/sec (nfs).  The kernel was 2.4.20.

Does anyone have any ideas?  I looked at ifconfig, vmstat, /proc/interrupts
but nothing looks out of the ordinary.

I almost want to just downgrade the machine, but i like the microstar board
better (faster cpu).

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
