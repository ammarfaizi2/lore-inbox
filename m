Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756735AbWKSQJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756735AbWKSQJy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 11:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756741AbWKSQJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 11:09:54 -0500
Received: from echo.digadd.de ([195.47.195.234]:38092 "EHLO mx2.digadd.de")
	by vger.kernel.org with ESMTP id S1756735AbWKSQJy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 11:09:54 -0500
Message-ID: <456081CE.9090205@digadd.de>
Date: Sun, 19 Nov 2006 17:09:50 +0100
From: Christian Schmidt <lkml@digadd.de>
User-Agent: Thunderbird 1.5.0.8 (X11/20061110)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: How to format a disk in an USB-Floppy-drive
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

How do I actually low-level format a floppy disk in an 
USB-Floppy-Disk-Drive?

I tried as with usual drives, using fdformat:

[~]>fdformat /dev/sdd
Could not determine current format type: Invalid argument

But setting the format failed as well:
[~]>setfdprm -p /dev/sdd 1440/1440
ioctl: Invalid argument

Next up scsifmt:

[~]>./scsifmt /dev/sdd fmt
scsifmt: non-sense ioctl error

Didn't work too well, too. Any ideas?

Best regards,
Christian
