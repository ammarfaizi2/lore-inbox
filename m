Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261880AbUJYPKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261880AbUJYPKz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 11:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbUJYPKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 11:10:25 -0400
Received: from ipx20189.ipxserver.de ([80.190.249.56]:51591 "EHLO
	ipx20189.ipxserver.de") by vger.kernel.org with ESMTP
	id S261861AbUJYOqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 10:46:50 -0400
Date: Mon, 25 Oct 2004 17:45:16 +0300 (EAT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.9-mm1: NForce3 problem (IRQ sharing issue?)
In-Reply-To: <200410251627.51939.rjw@sisk.pl>
Message-ID: <Pine.LNX.4.61.0410251740060.3029@musoma.fsmlabs.com>
References: <200410222354.44563.rjw@sisk.pl> <200410242308.31968.rjw@sisk.pl>
 <Pine.LNX.4.61.0410251709490.3029@musoma.fsmlabs.com> <200410251627.51939.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Oct 2004, Rafael J. Wysocki wrote:

> > So did the system still misbehave? What happened?
> 
> So far, so good.  The problem has not happened yet, so I think it won't.  
> Still, I have no such problems with 2.6.9*, although I do not boot them with 
> noapic ...
> 
> Thanks for your help anyway,

Ok, perhaps you shouldn't thank me ;) I actually sortof kinda broke your 
box... The reason why it worked before was because the kernel defaulted to 
disabling the IOAPIC on all nforce3 based systems but we found out that 
most nforce3 systems are actually work with the IOAPIC if we just ignore 
some bogus ACPI BIOS information. Your system happens to be one of the 
more broken ones, i'd actually like to try debug your problem a bit 
further, could you open up a bugzilla entry at bugzilla.kernel.org and 
email me when you're done. In the meantime, just keep booting with 
'noapic'

Thanks!
	Zwane
