Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261415AbVE2TeS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261415AbVE2TeS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 15:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbVE2TeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 15:34:17 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:490 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261415AbVE2TeP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 15:34:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=bWKQPE6UgpeR/NpMRqdVxjYM7qaQoyhZ6zCgp3OF/27knmy78IcBtJ00se2xUjAEdY+L4XFsMEN8naA/QpxhQAq5WhT/9pJNxV55mq+iPOvK09n82sKhMecL8PdJszmm2Ydr2Y0cN0M5LBjyWyjuoQktx3/JocRFl8wnaEESeuI=
Message-ID: <429A1930.6040409@gmail.com>
Date: Sun, 29 May 2005 15:34:08 -0400
From: Keenan Pepper <keenanpepper@gmail.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lm-sensors@lm-sensors.org
CC: linux-kernel@vger.kernel.org
Subject: SMSC LPC47M192 - "Device is disabled, will not use"
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a chip on my motherboard which says "SMsC LPC47M192-NC", but the kernel 
module for it (kernel 2.6.12-rc5-mm1) doesn't work:

keenan@localhost:~$ sudo modprobe smsc47m1
FATAL: Error inserting smsc47m1 
(/lib/modules/2.6.12-rc5-mm1/kernel/drivers/i2c/chips/smsc47m1.ko): No such device

In the dmesg output it says:

smsc47m1: Found SMSC LPC47M15x/LPC47M192
smsc47m1: Device is disabled, will not use

What does this mean? How do I get this chip to tell me fan speed and CPU 
temperature (if that's even what it does?)?
