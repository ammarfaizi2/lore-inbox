Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261938AbTIVS2T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 14:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbTIVS2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 14:28:19 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:32385 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261938AbTIVS2S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 14:28:18 -0400
Date: Mon, 22 Sep 2003 19:28:08 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Can we kill f inb_p, outb_p and other random I/O on port 0x80, in 2.6?
Message-ID: <20030922182808.GA28372@mail.jlokier.co.uk>
References: <m1isnlk6pq.fsf@ebiederm.dsl.xmission.com> <1064229778.8584.2.camel@dhcp23.swansea.linux.org.uk> <20030922162602.GB27209@mail.jlokier.co.uk> <1064248391.8895.6.camel@dhcp23.swansea.linux.org.uk> <1064250691.6235.2.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1064250691.6235.2.camel@laptop.fenrus.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> The first person to complain about the extra branch miss in udelay for
> this will get laughed at by me ;)

udelay(1) is too slow on a 386 even without the branch miss.

If you think I/O operations are infinitely slower than other
instructions, please explain why there is asm-optimised I/O code in
asm-i386/floppy.h.

:)

-- Jamie



