Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261690AbTILODn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 10:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbTILODn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 10:03:43 -0400
Received: from dsl092-073-159.bos1.dsl.speakeasy.net ([66.92.73.159]:22541
	"EHLO yupa.krose.org") by vger.kernel.org with ESMTP
	id S261690AbTILODm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 10:03:42 -0400
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NVIDIA proprietary driver problem
References: <87u17if7eu.fsf@nausicaa.krose.org>
	<Pine.LNX.4.51.0309121553500.14124@dns.toxicfilms.tv>
X-Home-Page: http://www.krose.org/~krose/
From: Kyle Rose <krose+linux-kernel@krose.org>
Organization: krose.org
Content-Type: text/plain; charset=US-ASCII
Date: Fri, 12 Sep 2003 10:03:22 -0400
In-Reply-To: <Pine.LNX.4.51.0309121553500.14124@dns.toxicfilms.tv> (Maciej
 Soltysiak's message of "Fri, 12 Sep 2003 15:54:55 +0200 (CEST)")
Message-ID: <87r82mf6j9.fsf@nausicaa.krose.org>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) XEmacs/21.4 (Rational FORTRAN,
 i386-debian-linux)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej Soltysiak <solt@dns.toxicfilms.tv> writes:

>> Sep 11 23:37:57 nausicaa kernel: 0: nvidia: Can't find an IRQ for your NVIDIA card!
>> Sep 11 23:37:57 nausicaa kernel: 0: nvidia: Please check your BIOS settings.
>> Sep 11 23:37:57 nausicaa kernel: 0: nvidia: [Plug & Play OS   ] should be set to NO
> I wonder why pnp os should be off?
> Linux does support pnp, and is a pnp os. Isn't it?
>
> Have you tried disabling apic? Maybe it's an apic or irq routing bug?

SMP without APIC doesn't make sense, but I suppose I could try running
a non-SMP kernel to see if the problem goes away.  Still, APIC is
active in test4 and the driver works there.

> What motherboard is it?

Tyan Tiger MP, dual Athlon MP 1800's.

Cheers,
Kyle
