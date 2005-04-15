Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261756AbVDOHif@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbVDOHif (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 03:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261760AbVDOHic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 03:38:32 -0400
Received: from fmr18.intel.com ([134.134.136.17]:35211 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261756AbVDOHi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 03:38:28 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16991.28529.930494.53255@sodium.jf.intel.com>
Date: Fri, 15 Apr 2005 00:38:25 -0700
To: gabriel <gabriel.j@telia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Booting from USB with initrd
In-Reply-To: <28347315.1113550056435.JavaMail.tomcat@pne-ps4-sn1>
References: <28347315.1113550056435.JavaMail.tomcat@pne-ps4-sn1>
X-Mailer: VM 7.19 under Emacs 21.3.1
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> gabriel  <gabriel.j@telia.com> writes:

> Hi Im trying to boot an encrypted file system using an initrd on a
> USB.  I use syslinux for the actual boot process as I couldnt get
> Grub to boot of it for some reason. This is the .cfg

> ...
> ...
> ...

> Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(1,0)
> followed by the USB information and stop.
> <5> Vendor SWISSBIT Mode: Victorinox 2.0 Rev 2.00
> Type Direct-Access ANSI SCSI Revision: 02
> SCSI device sdb: 1022720 512 byte hdwr sectors (524mb)
> sdb: Write Protect is off
> sdb: asuming driver cache: write-through

If this is the model of your disk, the USB device has been detected
properly, or at least it shows up. Are the contents encrypted you
said? Can you post a more complete log?

-- 

Inaky

