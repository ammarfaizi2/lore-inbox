Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750965AbWGUPma@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbWGUPma (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 11:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751018AbWGUPma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 11:42:30 -0400
Received: from mga02.intel.com ([134.134.136.20]:14425 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750894AbWGUPm3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 11:42:29 -0400
X-IronPort-AV: i="4.07,169,1151910000"; 
   d="scan'208"; a="68691692:sNHT3775306458"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Content-Transfer-Encoding: 8BIT
Subject: RE:  BUG? rebooting
Date: Fri, 21 Jul 2006 23:33:08 +0800
Message-ID: <554C5F4C5BA7384EB2B412FD46A3BAD1120717@pdsmsx411.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: BUG? rebooting
thread-index: AcasyYKWMny8WzYtRC6Cz0m57bSsNwAEP5+w
From: "Yu, Luming" <luming.yu@intel.com>
To: "?ukasz Jachymczyk" <lfx@tlen.pl>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 21 Jul 2006 15:33:12.0314 (UTC) FILETIME=[F9F615A0:01C6ACDA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

please take a look at bugziila.kernel.org
please try http://bugzilla.kernel.org/show_bug.cgi?id=6814
then try http://bugzilla.kernel.org/show_bug.cgi?id=6655

Thanks
Luming 

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org 
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of ?ukasz 
Jachymczyk
Sent: 2006“¥7Í≈21ÏÌ 21:19
To: linux-kernel@vger.kernel.org
Subject: BUG? rebooting

Hello,

I've got a problem with rebooting my linux on laptop hp nx6310 (centrino
core duo). After restarting, bios hangs for a while and it runs slower
then usual (up to 15 seconds until grub loads). After that, my 
linux works
quite fine, however I'm not able to achieve maximym cpu speed 
with cpufreq
and acpi doesn't show actual information about battery left (it 
shows all
the time 2:30 hours left) - simply, acpi hangs in the moment of booting.

But there is also ms windows on the same laptop. It reboots smoothly and
quickly. There is no bios hanging effect. And after such reboot from
windows, when I boot linux, everything - acpi and cpufreq - works fine!

I guess it's the problem of the way how linux' kernel reboots.
First, I thought that acpi is doing something nasty, so I 
compiled kernel
without power management support (in fact, this kernel contained only
essential features for my laptop, see .config:
http://fatcat.ftj.agh.edu.pl/~lfx/upload/kernel/config-clean). 
As you can
imagine, of course it didn't help.
Here is dmesg output on this kernel:
http://fatcat.ftj.agh.edu.pl/~lfx/upload/kernel/dmesg-clean

Here: http://fatcat.ftj.agh.edu.pl/~lfx/upload/kernel/ are also 
dmesg-acpi
and config-acpi files of my (almost) fully functional kernel. It does
reboot improperly too.

My question is: how can I make my linux to reboot smoothly as 
i.e. windows
does? What causes this problem? If it wasn't good place for asking about
this, please tell me where to find help. If you need more info about
what's happening on my laptop, please write.

-- 
®©ukasz Jachymczyk
http://fatcat.ftj.agh.edu.pl/~lfx/


-
To unsubscribe from this list: send the line "unsubscribe 
linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
