Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261254AbVABPBT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbVABPBT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 10:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbVABPBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 10:01:19 -0500
Received: from main.gmane.org ([80.91.229.2]:18057 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261254AbVABPBO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 10:01:14 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Georg Schild <dangertools@gmx.net>
Subject: cpu throttling powernow-k8 and acpi in kernel
Date: Sun, 02 Jan 2005 16:00:59 +0100
Message-ID: <41D80CAB.1060903@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 83.215.48.11
User-Agent: Mozilla Thunderbird 1.0 (X11/20041208)
X-Accept-Language: en-us, en
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys!

I have an acer aspire 1501 lmi with amd64 @3000+. i am running a gentoo 
64bit dist with vanilla 2.6.10 kernel on it.

i encounter some problems with the speed throttling of the cpu. this 
kind of cpu has 3 steps which a gouvernor can reach, 1800, 1600 and 
800Mhz. i am using the ondemand gouvernor. so far this works quite good, 
ondemand puts it at 800 until i do something. as it should be. i have 
also CONFIG_ACPI_PROCESSOR=y and CONFIG_ACPI_THERMAL=y enabled. when 
acpi thinks the temperature is too high (95° for cpu) it throttles the 
cpu down to 800Mhz, no care what ondemand tells it. okay, why not, is a 
good protection for overheating. but i don't think the cpu has 95°, i 
have run the laptop much hotter once, and there was no downthrottling. 
it cannot be that i am not able to compile a simple package without 
getting a critical temperature. i am watching the temps in gkrellm and 
this leads me to the thing that there is something wrong with it cause 
it jumps a bit when the temps are getting higher and one thing more, 
when the laptop is doing nothing, e.g. over night, screen is off, cpu is 
at 800 the temp is still at about 55° and more, how can that be? but i 
cannot disable the two acpi-options mentionend above. at first the cpu 
runs at 800, no problem, fan is almost off. but when i start e.g. a 
compilation first the fan starts spinning up a bit, the cpu goes to 
1800mhz but after a while the fan gives all the speed it is able to, 
much noise, and after one or 2 minutes the laptop switches off immediate.

Has anyone any idea on this? a tipp or something? i hope i did not 
forget any information.

Regards and keep on the good work

Georg Schild

