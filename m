Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263556AbTKDAbt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 19:31:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263573AbTKDAbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 19:31:49 -0500
Received: from fw.osdl.org ([65.172.181.6]:40389 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263556AbTKDAbs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 19:31:48 -0500
Date: Mon, 3 Nov 2003 16:31:44 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Charles Martin <martinc@ucar.edu>
cc: linux-kernel@vger.kernel.org, <martinc@atd.ucar.edu>
Subject: RE: interrupts across  PCI bridge(s) not handled
In-Reply-To: <000001c3a254$043d88c0$c3507580@atdsputnik>
Message-ID: <Pine.LNX.4.44.0311031630110.20373-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 3 Nov 2003, Charles Martin wrote:
> 
> I enabled ACPI, and the interrupts are now assigned correctly,
> and in the range of 48-51:

Good. 

> I didn't realize that ACPI is related to interrupt management 
> as well as power control. Is there any downside to using ACPI?

The downside to ACPI is that it's a complex standard, and with complexity 
comes the inevitable bugs. As you just found out, it does a lot more than 
just power control (the "C" is for "Configuration").

On some machines the ACPI support is even more broken than other BIOS 
tables, but it's getting better.

		Linus

