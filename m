Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261284AbTCTBVZ>; Wed, 19 Mar 2003 20:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261288AbTCTBVZ>; Wed, 19 Mar 2003 20:21:25 -0500
Received: from loki.a-q.co.uk ([195.224.50.15]:36366 "EHLO loki.a-q.co.uk")
	by vger.kernel.org with ESMTP id <S261284AbTCTBVY>;
	Wed, 19 Mar 2003 20:21:24 -0500
Date: Thu, 20 Mar 2003 01:32:24 +0000
From: James Wright <james@jigsawdezign.com>
To: linux-kernel@vger.kernel.org
Subject: P4 3.06Ghz Hyperthreading with 2.4.20?
Message-Id: <20030320013224.5311bdef.james@jigsawdezign.com>
Organization: Jigsaw Dezign
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

   I have kernel 2.4.20 with a single P4 3.06Ghz CPU and Asus P4G8X motherboard
(with the Intel E7205) Chipset. I have enabled Hyperthreading in the BIOS options,
compiled in SMP & ACPI support, and also tried adding "acpismp=force" to my lilo
kernel cmdline, but it just doesn't seem to detect the second Logical CPU. My 
current theory is that this is bcos Linux expects the motherboard to be an SMP
item (as with the Xeon boards) but this board is a Single processor board, ansd
doesn't have an MP table, but the cpu info is held in the ACPI tables.?!?

I have tried installing 2.5.65 but can't get past the compile due to compile-time
errors... Is this a known problem? SHall i just disable Hyperthreading until a new
kernel release?


Thanks,
James



