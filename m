Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbULIVrU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbULIVrU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 16:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261625AbULIVrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 16:47:20 -0500
Received: from host62-24-231-113.dsl.vispa.com ([62.24.231.113]:29150 "EHLO
	cenedra.walrond.org") by vger.kernel.org with ESMTP id S261169AbULIVrR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 16:47:17 -0500
From: Andrew Walrond <andrew@walrond.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 048 release
Date: Thu, 9 Dec 2004 21:47:14 +0000
User-Agent: KMail/1.7
Cc: Greg KH <greg@kroah.com>, linux-hotplug-devel@lists.sourceforge.net
References: <20041208185856.GA26734@kroah.com> <20041208192810.GA28374@kroah.com> <20041208194618.GA28810@kroah.com>
In-Reply-To: <20041208194618.GA28810@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412092147.14234.andrew@walrond.org>
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 Dec 2004 19:46, Greg KH wrote:
>
> Ok, version 048 has been released to fix the build errors for the
> extras/ directory.  It's available at
>  kernel.org/pub/linux/utils/kernel/hotplug/udev-048.tar.gz
>

I've built a boot cd with linux-2.6.10-rc3, udev 048 and latest hotplug.

When I boot a machine with my CD, udev doesn't create /dev/hda
I can't fathom why. Any reasons why it wouldn't create it?
It _has_ created /dev/hdc, (the cdrom drive) and all the other usual devices.

/proc/ide shows hda->ide0/hda
/proc/ide/ide0/hda/model = MAXTOR 6L040J2

This is a simple Asus P4PE m/b with intel ICH4 IDE.

( I know I can mknod, but since this is supposed to be a general purpose 
boot/toolkit CD, I'd like to make sure udev is working properly)

Any clues? hda currently contains windows server and I'm rather eager to wipe 
it ;)

Andrew Walrond
