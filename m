Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267943AbUJCN0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267943AbUJCN0n (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 09:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267936AbUJCN0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 09:26:43 -0400
Received: from [80.227.59.61] ([80.227.59.61]:14234 "EHLO HasBox.COM")
	by vger.kernel.org with ESMTP id S267935AbUJCN03 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 09:26:29 -0400
Message-ID: <415FFE77.7090908@HasBox.COM>
Date: Sun, 03 Oct 2004 17:28:23 +0400
From: Mitch <Mitch@HasBox.COM>
User-Agent: Application 0.6+ (X11/20041001)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ottdot@magma.ca, pavel@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3 software suspend (pmdisk) stopped working
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jesse,

as shown below, that is  not one of the options presented to me in my 
'disk' file

% cat /sys/power/disk
shutdown

My machine can only use the shutdown keyword - which worked in -rc3.

Mitch

-------- Original Message --------
Subject: Re: 2.6.9-rc3 software suspend (pmdisk) stopped working
Date: Sun, 03 Oct 2004 09:12:52 -0400
From: Jesse <ottdot@magma.ca>
To: Mitch <Mitch@0Bits.COM>
CC: pavel@suse.cz, linux-kernel@vger.kernel.org
References: <415FFA57.8040601@0Bits.COM>

Mitch wrote:
> Hi,
> 
> Ok, here is the kernel messages attached. Nothing of real value in it as 
> far as i can see (even with PM_DEBUG on), but you may spot something. 
> Basically the suspend process appears to start but the machine is never 
> powered off and the resume kernel routines are run immediately bringing 
> the kernel/system back to it's resumed state. The *same* kernel config 
> works on -rc2. If i hard power off the machine then i have to fsck my 
> disks on bootup (as expected) and the suspended image is not loaded.
> Clearly the latest patches have broken something but what ? Can anyone 
> else without ACPI suspend on -rc3 ?
> 

It's working for me on my Thinkpad 600x (ACPI is not compiled in) Used
'reboot' command from Documentation.power/swsusp.txt

Jesse


