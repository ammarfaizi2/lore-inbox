Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262433AbTIVTJo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 15:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262712AbTIVTJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 15:09:44 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:45117 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262433AbTIVTJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 15:09:43 -0400
To: Jamie Lokier <jamie@shareable.org>
Cc: Arjan van de Ven <arjanv@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Can we kill f inb_p, outb_p and other random I/O on port 0x80, in 2.6?
References: <m1isnlk6pq.fsf@ebiederm.dsl.xmission.com>
	<1064229778.8584.2.camel@dhcp23.swansea.linux.org.uk>
	<20030922162602.GB27209@mail.jlokier.co.uk>
	<1064248391.8895.6.camel@dhcp23.swansea.linux.org.uk>
	<1064250691.6235.2.camel@laptop.fenrus.com>
	<20030922182808.GA28372@mail.jlokier.co.uk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 22 Sep 2003 13:09:18 -0600
In-Reply-To: <20030922182808.GA28372@mail.jlokier.co.uk>
Message-ID: <m11xu8k5cx.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <jamie@shareable.org> writes:

> Arjan van de Ven wrote:
> > The first person to complain about the extra branch miss in udelay for
> > this will get laughed at by me ;)
> 
> udelay(1) is too slow on a 386 even without the branch miss.

Hmm.  I will have to test that one.
 
> If you think I/O operations are infinitely slower than other
> instructions, please explain why there is asm-optimised I/O code in
> asm-i386/floppy.h.
> 
> :)

Because the kernel was initially written in assembly and then fixed?

Eric

