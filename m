Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261830AbUJYO25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261830AbUJYO25 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 10:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261836AbUJYO2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 10:28:08 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:62904 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261818AbUJYOZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 10:25:54 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-mm1: NForce3 problem (IRQ sharing issue?)
Date: Mon, 25 Oct 2004 16:27:51 +0200
User-Agent: KMail/1.6.2
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>, Andrew Morton <akpm@osdl.org>
References: <200410222354.44563.rjw@sisk.pl> <200410242308.31968.rjw@sisk.pl> <Pine.LNX.4.61.0410251709490.3029@musoma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.61.0410251709490.3029@musoma.fsmlabs.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200410251627.51939.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 25 of October 2004 16:13, Zwane Mwaikambo wrote:
> On Sun, 24 Oct 2004, Rafael J. Wysocki wrote:
> 
> > > Could you boot 2.6.10-rc1 with the 'noapic' kernel parameter and you may 
> > > as well remove that pci=routeirq parameter, then send dmesg. Something 
> > > appears hosed with respect to IOAPIC setup and i think ACPI is having 
> > > trouble doing the fallback to PIC mode.
> > 
> > I booted with noapic and without pci=routeirq, although I think it's still 
> > necessary for suspend.
> 
> I think that was an -mm thing only at some point, but it's not in 
> mainline.

Yup.  You're right it's not necessary.

> 
> > The output of dmesg is attached (well, it's all I can 
> > currently produce - I don't know how to get anything better).
> 
> So did the system still misbehave? What happened?

So far, so good.  The problem has not happened yet, so I think it won't.  
Still, I have no such problems with 2.6.9*, although I do not boot them with 
noapic ...

Thanks for your help anyway,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
