Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbUB0Au0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 19:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbUB0AuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 19:50:05 -0500
Received: from webmail-outgoing.us4.outblaze.com ([205.158.62.67]:25055 "EHLO
	webmail-outgoing.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S261567AbUB0Aqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 19:46:32 -0500
X-OB-Received: from unknown (205.158.62.131)
  by wfilter.us4.outblaze.com; 27 Feb 2004 00:46:29 -0000
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Bob Dobbs" <bob_dobbs@linuxmail.org>
To: linux-kernel@vger.kernel.org
Date: Fri, 27 Feb 2004 08:46:31 +0800
Subject: Mobile Intel Pentium(R) 4 - M CPU 2.60GHz - kernel 2.6.3
X-Originating-Ip: 24.159.50.137
X-Originating-Server: ws5-1.us4.outblaze.com
Message-Id: <20040227004631.31D663982E7@ws5-1.us4.outblaze.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am currently running kernel 2.6.3 on my Dell Inspiron 8500 laptop.
I disabled all the ACPI and APM options in the kernel.

I have upgraded my bios
I have tried from kernel 2.4.23 up to mm and love-sources and my current kernel 2.6.3.

What happens is during heavy loads my cpu drops from 2.60GHz down to 1.20GHz, this happens for a few minutes, say 5 - 10 at the most. But performance while running a game, puts the game into slow motion. (Which  is weird because 1.20GHz should be more than enough to run all of the  games I currently have). I have read up on the documentation in /usr/src/linux/Documentation, under the "power" and "cpu-freq" but after disabling ACPI and such, those options do not seem to work anymore.

I have also tried running a program called "cpufreqd" which launches at boot time, but once again without ACPI enabled in the kernel this seems  not to work either. Also /sys/devices/system/cpu/cpu0/cpufreq/ has the following files.

cpuinfo_min_freq
cpuinfo_max_freq
scaling_min_freq
scaling_max_freq

I even tried to echo the options at bootup:

echo 2600000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq &
echo 2000000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq &

I tried to make those files set at: 2.00GHz min and 2.60GHz max, but something changes them right back to 1.20GHZ no matter what I do.

I am sure I am missing something, but atm I am totally lost.. and I could surely be doing everything wrong to begin with... that is why I am asking for help.

Is there a patch or anything to force the cpu to run at 2.60GHz all the time?

Thank you

-- 
______________________________________________
Check out the latest SMS services @ http://www.linuxmail.org 
This allows you to send and receive SMS through your mailbox.


Powered by Outblaze
