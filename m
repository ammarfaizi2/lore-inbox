Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964789AbVHYEfZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964789AbVHYEfZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 00:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964787AbVHYEfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 00:35:25 -0400
Received: from ms-smtp-01-smtplb.rdc-nyc.rr.com ([24.29.109.5]:55703 "EHLO
	ms-smtp-01.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id S964789AbVHYEfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 00:35:24 -0400
Date: Thu, 25 Aug 2005 00:35:22 -0400 (EDT)
Message-Id: <200508250435.j7P4ZM1g015411@ms-smtp-01.rdc-nyc.rr.com>
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

   >Also, tar should be an option instead of cpio for the archiver,
   >because tar is more widely used.
   >>pretty much everyone will have cpio and it's format is much
   >>simpler/cleaner to deal with
   >>if we want vastly more complex early-userspace semantics i think we
   >>need to carefully decide what is needed and how to put as much of that
   >>logic into userspace rather than hacking this much more in the kernel
   >>for fear of breaking things in subtle ways

I don't know, because tar is probably more widely used and
consequently people are more familiar with how to use it.

But, that is not as important as having the option of using tmpfs
as the initramfs.
