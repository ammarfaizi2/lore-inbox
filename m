Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130292AbRAQImI>; Wed, 17 Jan 2001 03:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130036AbRAQIl6>; Wed, 17 Jan 2001 03:41:58 -0500
Received: from edelweiss.qbik.ch ([193.8.58.68]:45586 "HELO edelweiss.qbik.ch")
	by vger.kernel.org with SMTP id <S130292AbRAQIlt>;
	Wed, 17 Jan 2001 03:41:49 -0500
Date: Wed, 17 Jan 2001 09:05:18 +0100
From: Markus Schlup <markus@qbik.ch>
To: linux-kernel@vger.kernel.org
Subject: ServerWorks IDE in 2.4.0-ac4
Message-ID: <20010117090518.E6826@edelweiss.qbik.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm currently playing around with a Compaq Proliant ML370 machine,
equipped with two Pentium-III 733 processors, 2 GB of RAM and two
18 GB SCSI harddisks.
While configuring to compile a 2.4.0-ac4 kernel, I activated the 
ServerWorks IDE chipset support, but when running this kernel, I had
no success in mounting the CDROM which is IDE based.
According to the dmesg log, the chipset is recognized, but
/proc/interrupts does not show an IDE interrupt, consequently the 
CDROM drive is not recognized.
Running this machine with a 2.2.18 kernel, I had no problem in mounting
the CDROM.
Please see http://www.qbik.ch/linux/ml370/ for logging information both
for 2.2.18 and 2.4.0-ac4 (.config, /proc/interrupts, /proc/meminfo,
/proc/cpuinfo, /proc/pci, output of lsmod and dmesg)
Btw: 2.4.0 plain gave the same results.

Thanks for any help,
Markus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
