Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbTKQXZM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 18:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262072AbTKQXZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 18:25:12 -0500
Received: from hell.org.pl ([212.244.218.42]:26885 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S261965AbTKQXZJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 18:25:09 -0500
Date: Tue, 18 Nov 2003 00:25:15 +0100
From: Karol Kozimor <sziwan@hell.org.pl>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [USB] uhci-hcd.c: b400: host controller halted after ACPI S3
Message-ID: <20031117232515.GA25925@hell.org.pl>
References: <20031117210528.GC20681@hell.org.pl> <1069110451.7394.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <1069110451.7394.1.camel@teapot.felipe-alfaro.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Felipe Alfaro Solana:
> > In brief: After resuming from S3 (Suspend-To-RAM), my USB hosts go very
> > bad.
> > 
> > Less short:
> > drivers/usb/host/uhci-hcd.c: b400: host system error, PCI problems?
> > drivers/usb/host/uhci-hcd.c: b400: host controller halted. very bad
> > drivers/usb/host/uhci-hcd.c: b400: host controller halted. very bad
> > 
> > Those messages appear in the logs after a successful S3 resume. The USB
> > mouse goes off and the HCDs work no more. Below is the lspci -v, attached
> > it the dmesg output. I'll be happy to provide more info.
> Try unloading uhci-hcd before suspending to S3. Then, load it again
> after the system has been woken up from S3. At least, it works for me

Oh, yeah, I know it does, I'm just trying to get the problem fixed
properly.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
