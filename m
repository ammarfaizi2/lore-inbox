Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262115AbTI0EBg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 00:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262117AbTI0EBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 00:01:36 -0400
Received: from rth.ninka.net ([216.101.162.244]:46002 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S262115AbTI0EBe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 00:01:34 -0400
Date: Fri, 26 Sep 2003 21:01:27 -0700
From: "David S. Miller" <davem@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: jdeas@jadsystems.com, linux-kernel@vger.kernel.org
Subject: Re: Prefered method to map PCI memory into userspace.
Message-Id: <20030926210127.3d33367d.davem@redhat.com>
In-Reply-To: <p73ad8r5hs1.fsf@oldwotan.suse.de>
References: <1064609623.16160.11.camel@ArchiveLinux.suse.lists.linux.kernel>
	<p73ad8r5hs1.fsf@oldwotan.suse.de>
X-Mailer: Sylpheed version 0.9.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Sep 2003 00:03:42 +0200
Andi Kleen <ak@suse.de> wrote:

> mmap on /dev/mem
> 
> PIO cannot be done on memory, for that you have to use iopl() 
> or ioperm() to get access to the port and then issue the PIO 
> instructions yourself

Platform dependant, mmap on /dev/mem doesn't work on many systems.
