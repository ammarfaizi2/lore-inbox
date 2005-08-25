Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbVHYPeH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbVHYPeH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 11:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932168AbVHYPeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 11:34:06 -0400
Received: from ms-smtp-01-smtplb.rdc-nyc.rr.com ([24.29.109.5]:28879 "EHLO
	ms-smtp-01.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id S932161AbVHYPeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 11:34:03 -0400
Date: Thu, 25 Aug 2005 11:34:01 -0400 (EDT)
Message-Id: <200508251534.j7PFY11g024729@ms-smtp-01.rdc-nyc.rr.com>
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-URL: mailto:linux-kernel@vger.kernel.org
X-Mailer: Lynx, Version 2.8.6dev.13c
From: robotti@godmail.com
Subject: Initramfs and TMPFS!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   >On Thu, Aug 25, 2005 at 12:35:22AM -0400, robotti@xxxxxxxxxxx wrote:
   >I don't know, because tar is probably more widely used and
   >consequently people are more familiar with how to use it.
   >>As I said before, the cpio format is cleaner/easier to parse in the
   >>kernel. Everyone has cpio probably so using tar isn't necessary.

Cpio is perhaps as available as tar, but it's not as used as tar.

Unless tar would be inordinately larger than a cpio implementation
(I can't imagine, but I'm not a coder!) I would prefer it.
 
   >But, that is not as important as having the option of using tmpfs
   >as the initramfs.
   >>Well, it's not clean that we really want this either. I have some
   >>niche needs for it but I suspect most people will never use such an
   >>option.

If initramfs replaces the old initrd method it should have something
as a filesystem that's robust and inspires confidence like ext2.

I know generally an initrd is used to load modules and prepare
the installation of a Linux system, so it doesn't require much
in a filesystem.

But, it can also be used to hold and run a complete Linux system,
so a more robust filesystem (tmpfs) is useful. 
