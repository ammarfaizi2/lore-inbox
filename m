Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129701AbRCGAE7>; Tue, 6 Mar 2001 19:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129727AbRCGAEt>; Tue, 6 Mar 2001 19:04:49 -0500
Received: from host55.osagesoftware.com ([209.142.225.55]:49164 "EHLO
	nic.osagesoftware.com") by vger.kernel.org with ESMTP
	id <S129701AbRCGAEf>; Tue, 6 Mar 2001 19:04:35 -0500
Message-Id: <4.3.2.7.2.20010306185522.00c54dd0@mail.osagesoftware.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Tue, 06 Mar 2001 19:04:14 -0500
To: linux-kernel@vger.kernel.org
From: David Relson <relson@osagesoftware.com>
Subject: 2.2.18 - do_try_to_free_pages failed
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is my first report of a kernel crash, so if there is more information 
wanted, please let me know and I'll do my best to supply it.

I'm running Mandrake 7.2 with a 2.2.18 kernel and GNOME, PIII 500 mhz, 
256MB ram, AIC789x SCSI on mobo, Fujitsu 18GB scsi HD, ATI video card.

This evening, xscreensaver crashed with a message saying (roughly):

	"xscreensaver hypercube had(?) a SIGSEGV"

I had to power down the machine and restart it.  From /var/log/messages the 
last message before the reboot and the first message after the reboot are:

Mar  6 16:35:32 osage kernel: VM: do_try_to_free_pages failed for kswapd...
Mar  6 17:13:04 osage syslogd 1.4-0: restart.

2.2.18 has run for as long as 71 days on this machine (at which point I 
restarted it to include the Sangoma WANROUTER driver, which was NOT running 
at the time of the crash).

I'll be glad to supply any additional info/files.  Just let me know what's 
wanted.

David
--------------------------------------------------------
David Relson                   Osage Software Systems, Inc.
relson@osagesoftware.com       Ann Arbor, MI 48103
www.osagesoftware.com          tel:  734.821.8800

