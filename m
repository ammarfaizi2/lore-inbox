Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262260AbTI0FJK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 01:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262265AbTI0FJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 01:09:10 -0400
Received: from ns.suse.de ([195.135.220.2]:50635 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262260AbTI0FJE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 01:09:04 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Prefered method to map PCI memory into userspace.
References: <1064609623.16160.11.camel@ArchiveLinux.suse.lists.linux.kernel>
	<20030926211740.GA27352@tsunami.ccur.com.suse.lists.linux.kernel>
	<1064623209.631.26.camel@gaston.suse.lists.linux.kernel>
	<20030926210034.3a1b4de7.davem@redhat.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 27 Sep 2003 07:09:01 +0200
In-Reply-To: <20030926210034.3a1b4de7.davem@redhat.com.suse.lists.linux.kernel>
Message-ID: <p7365je6cnm.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:

> If someone is looking for something to do, it would be incredibly
> value to make it so that all arches support this, and in particular
> get right the case of mmap()'ing the PCI host bridge.
> 
> If this were done, the PCI domain code in xfree86 could be enabled
> for all Linux platforms, not just the ones that have this implemented
> properly.

What semantics would it have? Can the "seek offset" just be the 
bus address?

If yes then it would be trivial to implement for x86/x86-64

-andi
