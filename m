Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262280AbTI0XxV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 19:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262285AbTI0XxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 19:53:21 -0400
Received: from pizda.ninka.net ([216.101.162.242]:57753 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262280AbTI0XxU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 19:53:20 -0400
Date: Sat, 27 Sep 2003 16:39:36 -0700
From: "David S. Miller" <davem@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Prefered method to map PCI memory into userspace.
Message-Id: <20030927163936.24861de4.davem@redhat.com>
In-Reply-To: <p7365je6cnm.fsf@oldwotan.suse.de>
References: <1064609623.16160.11.camel@ArchiveLinux.suse.lists.linux.kernel>
	<20030926211740.GA27352@tsunami.ccur.com.suse.lists.linux.kernel>
	<1064623209.631.26.camel@gaston.suse.lists.linux.kernel>
	<20030926210034.3a1b4de7.davem@redhat.com.suse.lists.linux.kernel>
	<p7365je6cnm.fsf@oldwotan.suse.de>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Sep 2003 07:09:01 +0200
Andi Kleen <ak@suse.de> wrote:

> "David S. Miller" <davem@redhat.com> writes:
> 
> > If someone is looking for something to do, it would be incredibly
> > value to make it so that all arches support this, and in particular
> > get right the case of mmap()'ing the PCI host bridge.
> > 
> > If this were done, the PCI domain code in xfree86 could be enabled
> > for all Linux platforms, not just the ones that have this implemented
> > properly.
> 
> What semantics would it have? Can the "seek offset" just be the 
> bus address?
> 
> If yes then it would be trivial to implement for x86/x86-64

I did everything for x86 already, egrep for "PCI_MMAP" under
arch/i386/.

The uncompleted part is the PCI host bridge mmap() support, I just
never got around to it.  Someone can easily complete it.
