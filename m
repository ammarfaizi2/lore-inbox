Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751955AbWFWTb6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751955AbWFWTb6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 15:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751938AbWFWTb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 15:31:58 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:61545 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751955AbWFWTb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 15:31:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=RtZGuhywG/2fAq0yZdJ3m5sH2QCIsriRyaN0Z/VkALegtx82fs0OoWJQOfYgpSom+mT6P+KxME1VgfqtmF5a1sT/UgomFry0trUZdi85sqUAwQktC5IWPGtGJbvqX9LoiP8GanXYLC9qIkL1DM/BFl2M+HNqMYws/B/iYWx1mWk=
Message-ID: <5a4c581d0606231231i181611dcn11f496f509629080@mail.gmail.com>
Date: Fri, 23 Jun 2006 21:31:56 +0200
From: "Alessandro Suardi" <alessandro.suardi@gmail.com>
To: "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: [2.6.17-git5] build warnings - cpufreq modules need {lock,unlock}_cpu_hotplug
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Early spotting...

if [ -r System.map -a -x /sbin/depmod ]; then /sbin/depmod -ae -F
System.map 2.6.17-git5; fi
WARNING: /lib/modules/2.6.17-git5/kernel/drivers/cpufreq/cpufreq_ondemand.ko
needs unknown symbol lock_cpu_hotplug
WARNING: /lib/modules/2.6.17-git5/kernel/drivers/cpufreq/cpufreq_ondemand.ko
needs unknown symbol unlock_cpu_hotplug
WARNING: /lib/modules/2.6.17-git5/kernel/drivers/cpufreq/cpufreq_conservative.ko
needs unknown symbol lock_cpu_hotplug
WARNING: /lib/modules/2.6.17-git5/kernel/drivers/cpufreq/cpufreq_conservative.ko
needs unknown symbol unlock_cpu_hotplug

--alessandro

 "I can't change what makes me high and I can't change what I believe in"
     (Heather Nova, "My Fidelity")
