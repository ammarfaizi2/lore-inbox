Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266206AbUAUXd4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 18:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266198AbUAUXdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 18:33:42 -0500
Received: from smtp.netcabo.pt ([212.113.174.9]:23105 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S266206AbUAUXcv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 18:32:51 -0500
Subject: Re: [ACPI] Re: PROBLEM: ACPI freezes 2.6.1 on boot
From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb@netcabo.pt>
To: "Georg C. F. Greve" <greve@gnu.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       acpi-devel <acpi-devel@lists.sourceforge.net>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <m34qupdj94.fsf@reason.gnu-hamburg>
References: <Pine.LNX.4.58.0401211051530.2123@home.osdl.org>
	<m3d69dhukz.fsf@reason.gnu-hamburg>
	<1074721887.3672.12.camel@darkstar.portugal> 
	<m34qupdj94.fsf@reason.gnu-hamburg>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9.7x.1) 
Date: 21 Jan 2004 23:31:43 +0000
Message-Id: <1074727903.3667.49.camel@darkstar.portugal>
Mime-Version: 1.0
X-OriginalArrivalTime: 21 Jan 2004 23:32:45.0224 (UTC) FILETIME=[DF37BA80:01C3E076]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So you are another APIC victim :)

The funny thing, is that I thought that because, 
Linus has write :
"It's entirely possible that the SCI is just horribly broken, and can't
be level-triggered" about "ACPI: IRQ 9 was Edge Triggered, setting to
Level Triggerd".

And thinking, can be true ? that, if SCI can't be level-triggered (like
my laptop and yours), kernel with APIC (loapic or smp) options will hang
on boot !

On Wed, 2004-01-21 at 22:33, Georg C. F. Greve wrote:
>  || On 21 Jan 2004 21:51:27 +0000
>  || Sérgio Monteiro Basto <sergiomb@netcabo.pt> wrote: 
> 
>  smb> And disable apic (lopic and io-pic) options from kernel compilation ?
> 
> Funny -- we seemed to have had the same idea. 
> 
> Yes, this makes it boot (see my other mail).
> 
> Regards,
> Georg
> 
> -- 
> Georg C. F. Greve                                       <greve@gnu.org>
> Free Software Foundation Europe	                 (http://fsfeurope.org)
> Brave GNU World	                           (http://brave-gnu-world.org)
-- 
Sérgio M B


