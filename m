Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964784AbVKLUcf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbVKLUcf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 15:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964785AbVKLUcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 15:32:35 -0500
Received: from mail.gmx.de ([213.165.64.20]:17075 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964784AbVKLUce (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 15:32:34 -0500
Date: Sat, 12 Nov 2005 21:32:32 +0100 (MET)
From: "Hans Klotz" <hans.klotz@gmx.net>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: Bootfailure with shuttle AN50R mainboard
X-Priority: 3 (Normal)
X-Authenticated: #30206620
Message-ID: <29865.1131827552@www61.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

SuSe 10.0 (Kernel 2.6.13) crashes when booting my system with
 a Shuttle AN50R main board (AMD 64 processor). I am using 
standard runlevel 3 to avoid problems from the graphical system.

With the standard grub paramaters, the systems seems to boot 
fine and a login prompt appears. However, at this point the
system does not reply to actions form the keyboard and it 
does not reply to ping from the local net.

I have tried acpi=oldboot (no difference) and acpi=off 
(hangs at initialization of pci bus) on the command line.
Finally, I set all actions, that where not on 'ignore', 
to 'notify' in /etc/sysconfig/powersave/events; further, 
I increased the debug level to 31.

The only suspicious line in /var/log/boot.mst ist last one:
<notice>killproc: kill(25405,3)
/var/log/messages does not contain entries that look suspicios 
to me.

The rescue system works fine (includeing power down).

There are 2 SATA disks in the system. /dev/sda1 is for swap, 
/dev/sda2 for root; the remaining partitions are not mounted 
at the present stage.

Has anyone experience with this phenomenon or even a remedy for it?

Hans Klotz

-- 
Telefonieren Sie schon oder sparen Sie noch?
NEU: GMX Phone_Flat http://www.gmx.net/de/go/telefonie
