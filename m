Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265823AbUAUVyk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 16:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266076AbUAUVyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 16:54:40 -0500
Received: from smtp.netcabo.pt ([212.113.174.9]:34379 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S265823AbUAUVwi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 16:52:38 -0500
Subject: Re: [ACPI] Re: PROBLEM: ACPI freezes 2.6.1 on boot
From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb@netcabo.pt>
To: "Georg C. F. Greve" <greve@gnu.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       acpi-devel <acpi-devel@lists.sourceforge.net>
In-Reply-To: <m3d69dhukz.fsf@reason.gnu-hamburg>
References: <Pine.LNX.4.58.0401211051530.2123@home.osdl.org> 
	<m3d69dhukz.fsf@reason.gnu-hamburg>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9.7x.1) 
Date: 21 Jan 2004 21:51:27 +0000
Message-Id: <1074721887.3672.12.camel@darkstar.portugal>
Mime-Version: 1.0
X-OriginalArrivalTime: 21 Jan 2004 21:52:29.0486 (UTC) FILETIME=[DD8EF4E0:01C3E068]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And disable apic (lopic and io-pic) options from kernel compilation ?


On Wed, 2004-01-21 at 21:15, Georg C. F. Greve wrote:
> || On 2004-01-21 18:56:59, Linus Torvalds wrote:
> 
>  > Does it go away if you just make "acpi_pic_set_level_irq()" do
>  > nothing (ie just remove the "outb()" call
>  > 
>  > 	arch/i386/kernel/acpi/boot.c line 273
>  > 
>  > or just make the if-statement be always false).
> 
>  > It's entirely possible that the SCI is just horribly broken, and
>  > can't be level-triggered.
> 
> Just tried removing the outb() call both from plain vanilla 2.6.1 and
> one with the latest ACPI patch. No change. The system freezes with the
> same message at the same point during bootup.
> 
> Any other ideas?
> 
> Regards,
> Georg

-- 
Sérgio M B


