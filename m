Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266900AbUHTNYA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266900AbUHTNYA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 09:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266917AbUHTNYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 09:24:00 -0400
Received: from relaycz.systinet.com ([62.168.12.68]:7626 "HELO
	relaycz.systinet.com") by vger.kernel.org with SMTP id S266900AbUHTNX5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 09:23:57 -0400
Subject: Re: [RFC] IBM thinkpad Fn+Fx key driver
From: Jan Mynarik <mynarikj@phoenix.inf.upol.cz>
To: erik@rigtorp.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040820122809.GA6167@linux.nu>
References: <20040820122809.GA6167@linux.nu>
Content-Type: text/plain
Message-Id: <1093008222.18934.9.camel@narsil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 20 Aug 2004 15:23:42 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Erik,

your module is working here on IBM ThinkPad R40 2681-BAG. Previously
non-working keys (Fn+ F3, F4, F5, F7, F8, F9, F12) are emitting ACPI
events now. Note that Fn+ F8, F9 are not marked with blue signs here on
R40, so there is no official function assigned :-).

Your driver even survives ACPI suspend to RAM (and wake-up too :-)) and
that's great.

Oops, I almost forgot to mention my kernel configuration: Debian's 2.6.7
(almost vanilla) + ACPI 20040715 (from acpi.sourceforge.net; I need it
for suspend to RAM).

I can't wait till it gets to mainstream 2.6 kernel.

That's all for this report.

Regards,

Jan "Pogo" Mynarik

On Fri, 2004-08-20 at 14:28, Erik Rigtorp wrote:
> I've written a driver for some of the extra keys on the thinkpads. The
> supported keys are: Fn+ F3, F4, F5, F7, F8, F9, F12. It has been tested on
> two diffrent thinkpad x31, but I would like some feedback from testing on
> other thinkpads. 
> 
> http://rigtorp.se/files/src/thinkpad-acpi.tar.gz
> 
> Just download, extract, run make and insmod thinkpad_acpi.ko
> 
> /Erik
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

