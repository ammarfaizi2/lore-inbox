Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265545AbUFYMZy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265545AbUFYMZy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 08:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265548AbUFYMZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 08:25:54 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:17076 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S265545AbUFYMZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 08:25:52 -0400
Date: Fri, 25 Jun 2004 14:03:47 +0100 (BST)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
X-X-Sender: tigran@localhost.localdomain
To: David van Hoose <david.vanhoose@comcast.net>
cc: Anton Altaparmakov <aia21@cam.ac.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Helge Hafting <helge.hafting@hist.no>,
       John Richard Moser <nigelenki@comcast.net>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Collapse ext2 and 3 please
In-Reply-To: <40DC180A.40204@comcast.net>
Message-ID: <Pine.LNX.4.44.0406251402240.15676-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jun 2004, David van Hoose wrote:
> [root@bahamut root]# /sbin/tune2fs -l /dev/sda2 | grep -i journal
> Filesystem features:      has_journal filetype needs_recovery sparse_super
> Journal inode:            8
> Journal backup:           inode blocks
> 

Ok, fine, and what does your /etc/lilo.conf or /etc/grub.conf look like?  
Are you passing "root=/dev/sda2" or "root=LABEL=/" to the kernel?

Kind regards
Tigran

