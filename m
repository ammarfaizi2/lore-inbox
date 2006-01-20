Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932176AbWATUnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbWATUnp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 15:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbWATUnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 15:43:45 -0500
Received: from smtpout.mac.com ([17.250.248.71]:46572 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932176AbWATUnp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 15:43:45 -0500
In-Reply-To: <0B1B67D811A178FB3BE70C96@d216-220-25-20.dynip.modwest.com>
References: <D1A7010C56BB90C4FA73E6DD@dhcp-2-206.wgops.com> <20060120155919.GA5873@stiffy.osknowledge.org> <B6DE6A4FC14860A23FE95FF3@d216-220-25-20.dynip.modwest.com> <20060120163551.GC5873@stiffy.osknowledge.org> <0B1B67D811A178FB3BE70C96@d216-220-25-20.dynip.modwest.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <07159468-E454-426D-AA8C-7A1CE1E2B22E@mac.com>
Cc: Marc Koschewski <marc@osknowledge.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Development tree, PLEASE?
Date: Fri, 20 Jan 2006 15:43:33 -0500
To: Michael Loftis <mloftis@wgops.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 20, 2006, at 12:06, Michael Loftis wrote:
> --On January 20, 2006 5:35:51 PM +0100 Marc Koschewski  
> <marc@osknowledge.org> wrote:
>> Moreover, as far as I remember... my devfsd -> udev transsition  
>> went as smooth as a reboot.
>
> The one machine I've got running 2.6+devfs under debian chokes in  
> initrd with an inability to find devfs during boot so I had to go  
> back to static /dev entries for it since atleast in sarge right now  
> I'm not seeing a quick-and-easy way to get devfs like support  
> bundled via mkinitrd, but I haven't looked, and I shouldn't have to.

Guess what, you _don't_ have to.  I have no less than 4 different 2.6  
debian boxes here, all booting the fully modular stock Debian kernels  
from software RAID on SATA or PATA (depends on the box).  Not only  
that, but I can shut down and rearrange those drives to different IDE/ 
SATA ports, then boot and it all still works with consistent /dev  
names (With the exception that I have to bump yaboot into booting  
from a different OpenFirmware path).  If you've customized and  
hardcoded a lot of the boot scripts, I can understand why things  
might be breaking, but the default initrds that the Debian tools  
generate work just fine for me.

Cheers,
Kyle Moffett

--
There is no way to make Linux robust with unreliable memory  
subsystems, sorry.  It would be like trying to make a human more  
robust with an unreliable O2 supply. Memory just has to work.
   -- Andi Kleen


