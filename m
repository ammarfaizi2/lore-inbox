Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262000AbUJYPhO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262000AbUJYPhO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 11:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261960AbUJYPep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 11:34:45 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:56250 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261951AbUJYP3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 11:29:14 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-mm1: NForce3 problem (IRQ sharing issue?)
Date: Mon, 25 Oct 2004 17:31:11 +0200
User-Agent: KMail/1.6.2
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>, Andrew Morton <akpm@osdl.org>
References: <200410222354.44563.rjw@sisk.pl> <200410251627.51939.rjw@sisk.pl> <Pine.LNX.4.61.0410251740060.3029@musoma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.61.0410251740060.3029@musoma.fsmlabs.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200410251731.11445.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 25 of October 2004 16:45, Zwane Mwaikambo wrote:
> On Mon, 25 Oct 2004, Rafael J. Wysocki wrote:
> 
> > > So did the system still misbehave? What happened?
> > 
> > So far, so good.  The problem has not happened yet, so I think it won't.  
> > Still, I have no such problems with 2.6.9*, although I do not boot them 
with 
> > noapic ...
> > 
> > Thanks for your help anyway,
> 
> Ok, perhaps you shouldn't thank me ;) I actually sortof kinda broke your 
> box... The reason why it worked before was because the kernel defaulted to 
> disabling the IOAPIC on all nforce3 based systems but we found out that 
> most nforce3 systems are actually work with the IOAPIC if we just ignore 
> some bogus ACPI BIOS information. Your system happens to be one of the 
> more broken ones, i'd actually like to try debug your problem a bit 
> further, could you open up a bugzilla entry at bugzilla.kernel.org and 
> email me when you're done. In the meantime, just keep booting with 
> 'noapic'

OK
The bugzilla entry is at:
http://bugzilla.kernel.org/show_bug.cgi?id=3639

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
