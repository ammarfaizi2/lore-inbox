Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265966AbUBKSIk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 13:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265954AbUBKSIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 13:08:40 -0500
Received: from mail4-141.ewetel.de ([212.6.122.141]:49077 "EHLO
	mail4.ewetel.de") by vger.kernel.org with ESMTP id S266005AbUBKSCj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 13:02:39 -0500
To: martinb@igotu.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.2, initrd, /dev/ram
In-Reply-To: <1nS8U-6lv-13@gated-at.bofh.it>
References: <1nS8U-6lv-13@gated-at.bofh.it>
Date: Wed, 11 Feb 2004 19:02:48 +0100
Message-Id: <E1AqyhE-0000Be-80@localhost>
From: der.eremit@email.de
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Feb 2004 03:20:08 +0100, you wrote in linux.kernel:

> However, the kernel will boot but -not- enter the ramdisk if
> root=/dev/ram. The entry has to be changed to root=/dev/ram0 in order
> for a successful boot.

Just use /dev/ram0, works in 2.4, too...

No idea why it was changed, but /dev/ram0 is at least a real LSB device
name, unlike /dev/ram (look on a real /dev, /dev/ram is usually a symlink
only present for backwards compatibility).

-- 
Ciao,
Pascal
