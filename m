Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263576AbTDWUCj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 16:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263578AbTDWUCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 16:02:39 -0400
Received: from [12.47.58.232] ([12.47.58.232]:37519 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263576AbTDWUCh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 16:02:37 -0400
Date: Wed, 23 Apr 2003 13:15:32 -0700
From: Andrew Morton <akpm@digeo.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: philippe.gramoulle@mmania.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5.67-mm4 & IRQ balancing
Message-Id: <20030423131532.3ad2e3eb.akpm@digeo.com>
In-Reply-To: <Pine.LNX.3.96.1030423153128.4451E-100000@gatekeeper.tmr.com>
References: <20030419133837.0118907b.akpm@digeo.com>
	<Pine.LNX.3.96.1030423153128.4451E-100000@gatekeeper.tmr.com>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Apr 2003 20:14:39.0902 (UTC) FILETIME=[F83DC3E0:01C309D4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen <davidsen@tmr.com> wrote:
>
> > - Can build irqbalanced into the intial initramfs image as part of kernel
> >   build. (lacking klibc, we would need to statically link against glibc)
> 
> Why, please? Unless you postulate that (a) the default kernel balance
> would be so bad the machine wouldn't boot, or (b) that the interface would
> be done only once at boot time, there's no reason for the user program to
> be in initramfs, is there? Let the distribution put it where other system
> things like ifconfig live.

Mainly as an exercise in using the initramfs infrastructure for something
real.  It's doubtful that irqbalanced would be started that way in real life.

