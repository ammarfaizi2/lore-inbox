Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261943AbVDETv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbVDETv6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 15:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261910AbVDETsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 15:48:31 -0400
Received: from hammer.engin.umich.edu ([141.213.40.79]:1507 "EHLO
	hammer.engin.umich.edu") by vger.kernel.org with ESMTP
	id S261923AbVDETrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 15:47:00 -0400
Date: Tue, 5 Apr 2005 15:46:54 -0400 (EDT)
From: Christopher Allen Wing <wingc@engin.umich.edu>
To: Andi Kleen <ak@muc.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: clock runs at double speed on x86_64 system w/ATI RS200 chipset
In-Reply-To: <20050405183141.GA27195@muc.de>
Message-ID: <Pine.LNX.4.58.0504051539490.13242@hammer.engin.umich.edu>
References: <200504031231.j33CVtHp021214@harpo.it.uu.se>
 <Pine.LNX.4.58.0504041050250.32159@hammer.engin.umich.edu> <m18y3x16rj.fsf@muc.de>
 <Pine.LNX.4.58.0504051351200.13242@hammer.engin.umich.edu>
 <20050405183141.GA27195@muc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 5 Apr 2005, Andi Kleen wrote:

> Try booting with acpi_skip_timer_override


Nope, this doesn't fix the problem. Here's the dmesg of 2.6.11.6 with
'acpi_skip_timer_override apic=debug':
	http://www-personal.engin.umich.edu/~wingc/apictimer/dmesg/dmesg-2.6.11.6-acpi-apicdebug-acpi_skip_timer_override

Here's /proc/interrupts:
	http://www-personal.engin.umich.edu/~wingc/apictimer/dmesg/interrupts-2.6.11-6-acpi-apicdebug-acpi_skip_timer_override


The clock still runs at double speed. The IRQ assignments seem to all have
been permuted, though, with 'acpi_skip_timer_override'


Thanks,
Chris
