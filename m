Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261558AbVCHE5I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261558AbVCHE5I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 23:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbVCHE5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 23:57:08 -0500
Received: from smtpout.mac.com ([17.250.248.84]:20703 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261558AbVCHE47 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 23:56:59 -0500
In-Reply-To: <1110241206.12485.27.camel@localhost.localdomain>
References: <1110234742.2456.37.camel@localhost.localdomain> <9e47339105030715034a8f8ff9@mail.gmail.com> <1110241206.12485.27.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <77E20AAF-8F8E-11D9-A2CF-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: greg@kroah.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, Jon Smirl <jonsmirl@gmail.com>,
       len.brown@intel.com
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC][PATCH] PCI bridge driver rewrite (rev 02)
Date: Mon, 7 Mar 2005 23:56:44 -0500
To: Adam Belay <abelay@novell.com>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 07, 2005, at 19:20, Adam Belay wrote:
> 6.) Open Firmware
>       * I don't know much about it, but I believe it does do similar
>         things to ACPI.
>       * Hopefully it uses EISA ids, but not really sure.  If not, it
>         wouldn't be included.

OpenFirmware is very similar to ACPI, except OpenFirmware interprets the
FORTH programs in the firmware itself, whereas ACPI does it in the OS.  
The
reason for the difference is that on Intel/x86 there is no compatible 
way to
call directly into the firmware from 32-bit code.  You won't find the 
two
on the same system, and they basically provide the same services: device
tree, power management, etc.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


