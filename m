Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262343AbVAUMD2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262343AbVAUMD2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 07:03:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262344AbVAUMD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 07:03:28 -0500
Received: from mail-06.iinet.net.au ([203.59.3.38]:29312 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262343AbVAUMDZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 07:03:25 -0500
Message-ID: <41F0F07B.3040805@iinet.com.au>
Date: Fri, 21 Jan 2005 23:07:23 +1100
From: Rodney McDonell <rodney@iinet.com.au>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kern:2.6.8, no cpufreq in sysfs
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

/sys/devices/system/cpu/cpu0/cpufreq does not exist.

kernel config -->
http://pods.dzite.com/4thegeeks/

My kernel config file is named cpufreq.txt. The other file is the 
README.Debian file found in the kernel-source doc directory. As you can 
see, it only patches, non-free stuff and firmware mainly.

I've looked at changelogs for 2.6.9 and 2.6.10 and whilst they helped me 
correct a previous error, this problem remains.

/etc/fstab does not contain an sysfs entry, however, /etc/mtab does :) 
I'm guessing this is a debian thing, because i've seen forums all over 
the web where apparently you have to have an entry in fstab. Looks like 
i dont need one. Maybe an old feature?

