Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263210AbUCXKYw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 05:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263281AbUCXKYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 05:24:52 -0500
Received: from fmr11.intel.com ([192.55.52.31]:44943 "EHLO
	fmsfmr004.fm.intel.com") by vger.kernel.org with ESMTP
	id S263210AbUCXKYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 05:24:47 -0500
Subject: Re: ACPI Shutdown 2.6.3
From: Len Brown <len.brown@intel.com>
To: Bruce Park <bpark@dolda2000.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615F5F35@hdsmsx402.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615F5F35@hdsmsx402.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1080123875.18508.254.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 24 Mar 2004 05:24:35 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bruce,
This failure is common on some laptops (except min;-(
and seems to have bubbled to near the top of the priority list.

acpi-devel@lists.sourceforge.net is the right place to discuss,
and this bug report is the right place to stash the info:
http://bugzilla.kernel.org/show_bug.cgi?id=1355

thanks,
-Len

On Sun, 2004-03-21 at 09:58, Bruce Park wrote:
> Dear LMKL users,
> 
> I'm experiencing a problem with ACPI and it's ability to shutdown the
> machine. I'm 
> currently using Debian GNU/Linux with the 2.6.3 kernel. Before I go
> on, if this is 
> the wrong type of material to post on this list, I apologize in
> advance. Kindly state 
> what I'm doing wrong and I will not make the same mistake.
> 
> The following information is about my mobo and BIOS:
> Award Modular BIOS v6.0
> 04/29/2002 - SiS745
> ASUS A7S333 ACPI BIOS rv 1006
> 
> When I run the shutdown command, the last thing I see is the
> following:
> Power Down
> acpi_power_off called
> hwsleep_0265 [24] acpi_enter_sleep_state: Entering sleep state [S5]
> 
> Here is a result of 'grep -i acpi /var/log/kern.log'. After looking at
> the output, I 
> realized that there was a pattern. I am pasting all the lines that
> aren't repetitious.
> http://www.dolda2000.com/~bpark/kern.log
> 
> This is just the output of dmesg:
> http://www.dolda2000.com/~bpark/dmesg.txt
> 
> I am using the testing release of Debian along with acpid version
> 1.0.3-2. The funny 
> thing is, I have used Fedora Core 1 and even Windows 2000 with ACPI
> and have been 
> able to shutdown the machine without any problems.
> 
> Any help is greatly appreciated.
> 
> bp
> 
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

