Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262569AbTKIPpM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 10:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262570AbTKIPpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 10:45:12 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:11908 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S262569AbTKIPpI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 10:45:08 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sun, 9 Nov 2003 07:45:08 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Alexander ZVYAGIN <Alexander.Zviagine@cern.ch>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PCI with SiS: Cannot allocate resource.
In-Reply-To: <200311091609.04985.Alexander.Zviagine@cern.ch>
Message-ID: <Pine.LNX.4.44.0311090742240.12198-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Nov 2003, Alexander ZVYAGIN wrote:

> Hello Davide,
> 
> and thanks for the answer.
> 
> > Can you try to apply this over test9:
> >
> > http://www.kernel.org/pub/linux/kernel/v2.6/snapshots/patch-2.6.0-test9-bk1
> >3.bz2
> 
> I see the same messages...

$ cat /proc/interrupts

Also you can try to disable:

CONFIG_X86_UP_APIC
CONFIG_X86_UP_IOAPIC
CONFIG_X86_LOCAL_APIC
CONFIG_X86_IO_APIC



- Davide


