Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261448AbVDOJZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261448AbVDOJZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 05:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261780AbVDOJZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 05:25:57 -0400
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:43476 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S261448AbVDOJZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 05:25:52 -0400
Message-ID: <22151575.1113557151100.JavaMail.tomcat@pne-ps1-sn2>
Date: Fri, 15 Apr 2005 11:25:51 +0200 (MEST)
From: gabriel <gabriel.j@telia.com>
Reply-To: gabriel <gabriel.j@telia.com>
To: linux-kernel@vger.kernel.org
Subject: Sv: Re: Booting from USB with initrd
Mime-Version: 1.0
Content-Type: text/plain;charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Mailer: CP Presentation Server
X-clientstamp: [193.183.200.66]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-15 at 09:27 +0200, gabriel wrote:
> Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block
(1,0)

>Hi Gabriel!

Hi!

>It looks like initrd.gz could not be mounted. The unknown-block(1,0)
>is /dev/ram0 (and has normally initrd attached to it) as specified on
>kernel command line.

>Do you use an initrd or an initramfs? Is the kernel compiled with initrd
>support? Is the ramdisk size big enough to hold your initrd?

I'm no really sure what the difference is. initrd.gz is a compressed file 
with a minix on it. Its created automaticly with build-initrd.sh from loop-
aes 
package.

the ramdisk is 4096 which should be sufficient and yes the kernel has intrd 
support.

>regards


