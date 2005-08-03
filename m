Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262136AbVHCH5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262136AbVHCH5u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 03:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262137AbVHCH5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 03:57:49 -0400
Received: from ns1.axalto.com ([194.98.128.2]:43196 "EHLO
	cro-su-02.croissy.axalto.com") by vger.kernel.org with ESMTP
	id S262136AbVHCH5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 03:57:41 -0400
Date: Wed, 03 Aug 2005 09:57:39 +0200
From: bgerard <bgerard@axalto.com>
Subject: hotplug problem
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <42F078F3.4040808@axalto.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I'm working on an embeded system with linux kernel 2.4.27 and busybox 
1.00. Lately I've decided to add hotplug feature to my kernel in order 
to automaticaly mount usb keys.

When I plug the usb key, I can see in the kernel debug that 
"/sbin/hotplug" is called but my script is not executed. I've tried to 
replace the hotplug script by a simple one but nothing appeared. Here is 
my script :
#!/bin/sh
echo "usb key un/plugged"

The script is working when I run it myself (./sbin/hotplug )

I've also noticed that when kmod try to call modprobe, it's not executed 
while the debug message says that everything went fine.

Can anyone help me ?
Thanks in advance.
Ben.
