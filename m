Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267923AbUJCNPo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267923AbUJCNPo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 09:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267928AbUJCNPo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 09:15:44 -0400
Received: from mx1.magmacom.com ([206.191.0.217]:27348 "EHLO mx1.magmacom.com")
	by vger.kernel.org with ESMTP id S267923AbUJCNPl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 09:15:41 -0400
Message-ID: <415FFAD4.2020605@magma.ca>
Date: Sun, 03 Oct 2004 09:12:52 -0400
From: Jesse <ottdot@magma.ca>
User-Agent: Mozilla Thunderbird 0.7.3 (Windows/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mitch <Mitch@0Bits.COM>
CC: pavel@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3 software suspend (pmdisk) stopped working
References: <415FFA57.8040601@0Bits.COM>
In-Reply-To: <415FFA57.8040601@0Bits.COM>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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


