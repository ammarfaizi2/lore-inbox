Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290841AbSBLJIT>; Tue, 12 Feb 2002 04:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290845AbSBLJIJ>; Tue, 12 Feb 2002 04:08:09 -0500
Received: from smtp1.vol.cz ([195.250.128.73]:38153 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id <S290839AbSBLJIA>;
	Tue, 12 Feb 2002 04:08:00 -0500
Date: Mon, 11 Feb 2002 21:48:11 +0100
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
        Patrick Mochel <mochel@osdl.org>
Subject: Small notes about /proc/driver
Message-ID: <20020211204811.GA131@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

root@amd:/proc/driver/root/pci0/00:02.0# cat irq
11root@amd:/proc/driver/root/pci0/00:02.0#
root@amd:/proc/driver/root/pci0/00:02.0# cat power
0
root@amd:/proc/driver/root/pci0/00:02.0# cat resources

-> irq does not include newline while power does. Probably irq should
add a newline for consistency.

I briefly tested usb support in driver. You really should figure out
some name ;-).
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
