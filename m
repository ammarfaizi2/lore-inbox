Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261345AbULHUB1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbULHUB1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 15:01:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261346AbULHUB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 15:01:27 -0500
Received: from ip126.globalintech.pl ([62.89.81.126]:31202 "EHLO
	MAILSERVER.dmz.globalintech.pl") by vger.kernel.org with ESMTP
	id S261345AbULHUBM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 15:01:12 -0500
Message-ID: <41B75D85.8060302@globalintech.pl>
Date: Wed, 08 Dec 2004 21:01:09 +0100
From: Blizbor <kernel@globalintech.pl>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [crash] 2.4.22 and Can't locate module char-major-30
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Dec 2004 20:01:09.0603 (UTC) FILETIME=[A90D3330:01C4DD60]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have defined "*.* /dev/pty/1" in the /etc/syslogd.conf and the last 
line I saw before crash was

Dec  8 19:29:42 oracle-srv-03 modprobe: modprobe: Can't locate module 
char-major-30

Could these two things be related ?
What can cause such a crash ?
I have RH 9 with custom compiled kernel and it was working about 300 days
without any problems.
I'm using e100, ide, ext3, jfs and oracle 9i on this machine.

Regards,
Blizbor
