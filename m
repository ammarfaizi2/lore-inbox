Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132077AbRDTWeN>; Fri, 20 Apr 2001 18:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132118AbRDTWeC>; Fri, 20 Apr 2001 18:34:02 -0400
Received: from ns2.cypress.com ([157.95.67.5]:953 "EHLO ns2.cypress.com")
	by vger.kernel.org with ESMTP id <S132077AbRDTWd7>;
	Fri, 20 Apr 2001 18:33:59 -0400
Message-ID: <3AE0B945.22A3CABB@cypress.com>
Date: Fri, 20 Apr 2001 17:33:41 -0500
From: Thomas Dodd <ted@cypress.com>
Organization: Cypress Semiconductor Southeast Design Center
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en-US, en-GB, en, de-DE, de-AT, de-CH, de, zh-TW, zh-CN, zh
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Wayne.Brown@altec.com
Subject: Re: Current status of NTFS support
In-Reply-To: <86256A34.0079A841.00@smtpnotes.altec.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wayne.Brown@altec.com wrote:
> 
> partition.  The upgrade, though, will involve wiping the hard drive, allocating
> the whole drive to a single NTFS partition, and reinstalling Notes after
> installing Windows 2000 .  That means bye-bye FAT32 partition and hello NTFS.  I
> can't mount it read-only because I'll still have to update my Notes databases
> from Linux.  So how risky is this?

Why? Just us FAT32 instead of NTFS.Also, Why the repartition?
Just reformat the old FAT32 partition and install over that.

> Also, I'll have to recreate my Linux partitions after the upgrade.  Does anyone

Oll you should need is a boot floppy to get back into linux and fix
the MBR (rerun lilo?) after the Windows install.

Don't try to write to and NTFS partition from linux.
You probably don't want to mount the Win2k version of
NTFS in linux either. At one point that could damage the
filesystem too.

	-Thomas
