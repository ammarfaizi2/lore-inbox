Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270741AbTG0LIQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 07:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270745AbTG0LIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 07:08:16 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:21214 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S270741AbTG0LIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 07:08:12 -0400
Date: Sun, 27 Jul 2003 13:23:21 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [TRIVIAL] use ext2/ext3 consistently in Kconfig
Message-ID: <20030727112321.GF17724@louise.pinerecords.com>
References: <20030726195722.GB16160@louise.pinerecords.com> <1059303927.12758.10.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1059303927.12758.10.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [alan@lxorguk.ukuu.org.uk]
> 
> It is called ext3 not ext2. This change is dubious (actually the big
> problem is it is totally unclear what we are discussing the name of.
> How about
> 
>   Ext3 is the journalling versions of the second extended file system
> (ext2). Ext2 was the former de-facto standard Linux file system. Ext3
> uses the same on disk layout but with a journal.
>  ...

I already posted a patch that read:

+         Ext3 is a journaling version of the Second extended fs
+         (or just ext2fs), the de facto standard Linux filesystem
+         (method to organize files on a storage device) for block
+         devices such as hard disk partitions.

I can resend with your version, though we have an almost perfect match
as far as the first clause goes. :)

-- 
Tomas Szepe <szepe@pinerecords.com>
