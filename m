Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261557AbVCYJNZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261557AbVCYJNZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 04:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261558AbVCYJNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 04:13:25 -0500
Received: from smtp.uninet.ee ([194.204.0.4]:9989 "EHLO smtp.uninet.ee")
	by vger.kernel.org with ESMTP id S261557AbVCYJNW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 04:13:22 -0500
Message-ID: <4243D65A.2050007@tuleriit.ee>
Date: Fri, 25 Mar 2005 11:14:02 +0200
From: Indrek Kruusa <indrek.kruusa@tuleriit.ee>
Reply-To: indrek.kruusa@tuleriit.ee
User-Agent: Mozilla Thunderbird 1.0 (X11/20050215)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Intel MB + P4 HT: bios processors logo depends on what?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A bit silly point maybe but it is somewhat interesting what makes BIOS 
on Intel motherboard decide which processor's logo to display.

Situation:

a) Fedora Core 4 test1  + kernel-2.6.11-1.1177_FC4smp
- going to reboot from fedora the bios shows always processors logo with 
HT marks

b) Mandrake 10.2 rc1 + kernel-2.6.11-5mdksmp
- after reboot there is processor logo without HT marks

c) Mandrake + kernel-2.6.12-rc1-mm1 (compiled with SMP+SMT)
- same as b)


There is nothing wrong with those kernels but it is interesting why 
Fedora's kernel (acpi daemon?) is somewhat special here.

thanks,
Indrek

