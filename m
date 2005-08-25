Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932179AbVHYPiw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbVHYPiw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 11:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbVHYPiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 11:38:52 -0400
Received: from ms-smtp-01-smtplb.rdc-nyc.rr.com ([24.29.109.5]:44769 "EHLO
	ms-smtp-01.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id S932179AbVHYPiw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 11:38:52 -0400
Date: Thu, 25 Aug 2005 11:38:49 -0400 (EDT)
Message-Id: <200508251538.j7PFcn1g000143@ms-smtp-01.rdc-nyc.rr.com>
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


   >Right, but it would be nice to have that option if initramfs
   >using tmpfs becomes part of the kernel.
   >>But it's not needed so why add bloat?

A 'tmpfs_size' option seems to just make sense given the fact that
the mount program has a 'size' option for tmpfs.

It makes sense if tmpfs becomes am initramfs option. 

It's one less thing to do in an init script.

What if you have a root.cpio.gz that requires 200MB to hold, but you
only have 300MB of memory?

50% of total memory wouldn't hold it, but 90% etc. would (tmpfs_size=90%).
 
