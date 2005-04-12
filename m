Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262102AbVDLKXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262102AbVDLKXk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 06:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbVDLKXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 06:23:39 -0400
Received: from fire.osdl.org ([65.172.181.4]:42181 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262102AbVDLKXb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:23:31 -0400
Date: Tue, 12 Apr 2005 03:23:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: incoming
Message-Id: <20050412032322.72d73771.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As the commits list probably isn't working at present I'll cc linux-kernel
on this lot.  Fairly cruel, sorry, but I don't like the idea of people not
knowing what's hitting the main tree.



This is the first live test of Linus's git-importing ability.  I'm about
to disappear for 1.5 weeks - hope we'll still have a kernel left when I
get back.

- As we're still a fair way from 2.6.12 and things are still backing up,
  it's a relatively large update.

- Various arch updates

- Big x86_64 update, as discussed

- decent-sized ppc32, ppc64 updates

- big infiniband update

- very nearly the last batch of u32->pm_message_t conversions.  Some
  other bits of this will be sitting out in subsystem trees - this is just
  the stuff which doesn't overlap.

- the important fixes from the md, nfs4 queues

- other random fixes and things we probably want to have in 2.6.12.

- I'd draw especial Linus attention to:

	"fix crash in entry.S restore_all" and
	"pci enumeration on ixp2000: overflow in kernel/resource.c"


