Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbTKQXHf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 18:07:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261947AbTKQXHf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 18:07:35 -0500
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:5892 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S261892AbTKQXHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 18:07:34 -0500
Subject: Re: [USB] uhci-hcd.c: b400: host controller halted after ACPI S3
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Karol Kozimor <sziwan@hell.org.pl>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <20031117210528.GC20681@hell.org.pl>
References: <20031117210528.GC20681@hell.org.pl>
Content-Type: text/plain
Message-Id: <1069110451.7394.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Tue, 18 Nov 2003 00:07:32 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-11-17 at 22:05, Karol Kozimor wrote:
> Hi,
> In brief: After resuming from S3 (Suspend-To-RAM), my USB hosts go very
> bad.
> 
> Less short:
> drivers/usb/host/uhci-hcd.c: b400: host system error, PCI problems?
> drivers/usb/host/uhci-hcd.c: b400: host controller halted. very bad
> drivers/usb/host/uhci-hcd.c: b400: host controller halted. very bad
> 
> Those messages appear in the logs after a successful S3 resume. The USB
> mouse goes off and the HCDs work no more. Below is the lspci -v, attached
> it the dmesg output. I'll be happy to provide more info.

Try unloading uhci-hcd before suspending to S3. Then, load it again
after the system has been woken up from S3. At least, it works for me
:-)

