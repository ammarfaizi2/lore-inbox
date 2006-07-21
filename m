Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbWGUNZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbWGUNZU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 09:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750731AbWGUNZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 09:25:20 -0400
Received: from main.gmane.org ([80.91.229.2]:40651 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750730AbWGUNZT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 09:25:19 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-2?q?=A3ukasz_Jachymczyk?= <lfx@tlen.pl>
Subject: BUG? rebooting
Date: Fri, 21 Jul 2006 15:18:37 +0200
Message-ID: <pan.2006.07.21.13.18.37.180629@tlen.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: awj146.internetdsl.tpnet.pl
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've got a problem with rebooting my linux on laptop hp nx6310 (centrino
core duo). After restarting, bios hangs for a while and it runs slower
then usual (up to 15 seconds until grub loads). After that, my linux works
quite fine, however I'm not able to achieve maximym cpu speed with cpufreq
and acpi doesn't show actual information about battery left (it shows all
the time 2:30 hours left) - simply, acpi hangs in the moment of booting.

But there is also ms windows on the same laptop. It reboots smoothly and
quickly. There is no bios hanging effect. And after such reboot from
windows, when I boot linux, everything - acpi and cpufreq - works fine!

I guess it's the problem of the way how linux' kernel reboots.
First, I thought that acpi is doing something nasty, so I compiled kernel
without power management support (in fact, this kernel contained only
essential features for my laptop, see .config:
http://fatcat.ftj.agh.edu.pl/~lfx/upload/kernel/config-clean). As you can
imagine, of course it didn't help.
Here is dmesg output on this kernel:
http://fatcat.ftj.agh.edu.pl/~lfx/upload/kernel/dmesg-clean

Here: http://fatcat.ftj.agh.edu.pl/~lfx/upload/kernel/ are also dmesg-acpi
and config-acpi files of my (almost) fully functional kernel. It does
reboot improperly too.

My question is: how can I make my linux to reboot smoothly as i.e. windows
does? What causes this problem? If it wasn't good place for asking about
this, please tell me where to find help. If you need more info about
what's happening on my laptop, please write.

-- 
£ukasz Jachymczyk
http://fatcat.ftj.agh.edu.pl/~lfx/


