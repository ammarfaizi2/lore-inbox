Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263506AbTDIPOg (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 11:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263508AbTDIPOg (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 11:14:36 -0400
Received: from dodge.jordet.nu ([217.13.8.142]:58072 "EHLO dodge.hybel")
	by vger.kernel.org with ESMTP id S263506AbTDIPOf (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 11:14:35 -0400
Subject: i2c questions in kernel 2.5.67
From: Stian Jordet <liste@jordet.nu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1049902006.1362.6.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 09 Apr 2003 17:26:46 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a Asus CUV266-DLS motherboard, with a as99127f hardware monitor
chip. This is supposed to be supported by the W83781D sensor driver.

But, I'm I not supposed to get something under /sys/bus/i2c? Now it's
only my tv-card that is listed as a device.

chevrolet:~# find /sys/bus/i2c/
/sys/bus/i2c/
/sys/bus/i2c/drivers
/sys/bus/i2c/drivers/i2c TV tuner dri
/sys/bus/i2c/drivers/i2c TV tuner dri/1-0060
/sys/bus/i2c/drivers/w83781d
/sys/bus/i2c/drivers/i2c-dev dummy dr
/sys/bus/i2c/devices
/sys/bus/i2c/devices/1-0060
chevrolet:~# 

Have I a somewhat incompatible motherboard? The chip on the board _is_ a
as99127f, seen with my own eyes :) Or is there some other option I need?

Thanks,

Best regards,
Stian

