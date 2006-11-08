Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161361AbWKHWIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161361AbWKHWIb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 17:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161726AbWKHWIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 17:08:31 -0500
Received: from www.osadl.org ([213.239.205.134]:51143 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1161361AbWKHWIa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 17:08:30 -0500
Subject: Re: 2.6.19-rc5-mm1
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Benoit Boissinot <bboissin@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <40f323d00611080708j2eeaefc1kee4f22211d3f276d@mail.gmail.com>
References: <20061108015452.a2bb40d2.akpm@osdl.org>
	 <40f323d00611080708j2eeaefc1kee4f22211d3f276d@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 08 Nov 2006 23:10:41 +0100
Message-Id: <1163023841.8335.93.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-08 at 16:08 +0100, Benoit Boissinot wrote:
> I have the following traceback during boot:
> [   20.359613] BUG: unable to handle kernel NULL pointer dereference
> at virtual address 00000000
> [   20.359618]  printing eip:
> [   20.359620] 00000000
>
> reverting:
> i386-apic-timer-use-clockevents-broadcast.patch
> acpi-verify-lapic-timer.patch
> acpi-verify-lapic-timer-exports.patch
> acpi-verify-lapic-timer-fix.patch

Yep, my bad. working on a fix

	tglx


