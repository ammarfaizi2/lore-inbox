Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932284AbVLDUZf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbVLDUZf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 15:25:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932330AbVLDUZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 15:25:35 -0500
Received: from [82.94.235.172] ([82.94.235.172]:16344 "EHLO
	mail.hipersonik.com") by vger.kernel.org with ESMTP id S932284AbVLDUZe
	(ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 15:25:34 -0500
From: Norbert van Nobelen <norbert-kernel@hipersonik.com>
Organization: Hipersonik.com
To: Jeff Dike <jdike@addtoit.com>
Subject: Change suggestion for UML config (Was: UML with 2.6.14-3 kernel)
Date: Sun, 4 Dec 2005 21:28:21 +0100
User-Agent: KMail/1.8.2
Cc: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
References: <200512042029.32038.norbert-kernel@hipersonik.com> <20051204204132.GA29782@ccure.user-mode-linux.org>
In-Reply-To: <20051204204132.GA29782@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512042128.22076.norbert-kernel@hipersonik.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, missed it in the config.
A change suggestion for the UML config:
Alter config explanation for UBD (blockdevices/virtual block device) to:
Always do synchonous disk IO for UBD (needed for UML!)

Because at this moment it is easier to find by editing the generated .config 
file instead of by using the kernel configuration tools.

On Sunday 04 December 2005 21:41, Jeff Dike wrote:
> On Sun, Dec 04, 2005 at 08:29:31PM +0100, Norbert van Nobelen wrote:
> > VFS: Cannot open root device "/tmp/root_fs" or unknown-block(0,0)
> > Please append a correct "root=" boot option
> > Kernel panic - not syncing: VFS: Unable to mount root fs on
> > unknown-block(0,0)
>
> You don't have the UBD driver configured in?
>
> Start over with a defconfig - that will give you a sane configuration.
>
> 				Jeff

-- 
________
www.hipersonik.com : Open source experts
