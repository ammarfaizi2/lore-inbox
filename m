Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267803AbTBEFSd>; Wed, 5 Feb 2003 00:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267804AbTBEFSd>; Wed, 5 Feb 2003 00:18:33 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:21518 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267803AbTBEFSc>;
	Wed, 5 Feb 2003 00:18:32 -0500
Date: Tue, 4 Feb 2003 21:23:54 -0800
From: Greg KH <greg@kroah.com>
To: Jeff Garzik <jgarzik@pobox.com>, hpa@zytor.com,
       Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: klibc update
Message-ID: <20030205052354.GL15544@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For those wondering what's happening with klibc, here's an update...

I have it building relatively well within the kernel, and have modified
the usr/gen_init_cpio.c file to add files to the cpio "blob".  That all
seems to work, but I don't seem to be able to extract the files properly
(or at least that's what I'm guessing is happening).

If anyone wants to see the current progress, there's a big patch against
2.5.59 at:
	kernel.org/pub/linux/kernel/people/gregkh/klibc/klibc-2.5.59.patch.gz
and a bk tree with the different changes broken down into "logical"
chunks at:
	bk://kernel.bkbits.net/gregkh/linux/klibc-2.5

Any help with trying to debug init/initramfs.c to figure out what is
going wrong would be greatly appreciated.

thanks,

greg k-h
