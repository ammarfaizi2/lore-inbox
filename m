Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261312AbVABUJK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbVABUJK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 15:09:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261314AbVABUJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 15:09:10 -0500
Received: from tabit.netstar.se ([195.178.179.33]:54219 "HELO tabit.netstar.se")
	by vger.kernel.org with SMTP id S261312AbVABUJH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 15:09:07 -0500
Subject: Re: 2.6.10: e100 network broken after swsusp/resume
From: =?ISO-8859-1?Q?H=E5kan?= Lindqvist <lindqvist@netstar.se>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20050102184239.GA21322@butterfly.hjsoft.com>
References: <20041228144741.GA2969@butterfly.hjsoft.com>
	 <20050101172344.GA1355@elf.ucw.cz>
	 <20050102055753.GB7406@ip68-4-98-123.oc.oc.cox.net>
	 <20050102184239.GA21322@butterfly.hjsoft.com>
Content-Type: text/plain; charset=ISO-8859-15
Date: Sun, 02 Jan 2005 21:09:16 +0100
Message-Id: <1104696556.2478.12.camel@pefyra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On sön, 2005-01-02 at 13:42 -0500, John M Flinchbaugh wrote:
> pci=routeirq worked for me to get my e100 working again after resume.

For the record: It works around my problems with e100 and snd-intel8x0,
too.

> 
> so what's that mean?  what's the trade-off for using this option?


The Documentation/kernel-parameters.txt says this about pci=routeirq:
"Do IRQ routing for all PCI devices. This is normally done in
pci_enable_device(), so this option is a temporary workaround for broken
drivers that don't call it."

Ie, it doesn't sound too bad to use it until the problem is solved.
And I don't know if this particular issue is a case of broken drivers,
but that was what the parameter was added to work around.


/Håkan

