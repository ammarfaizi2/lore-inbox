Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268778AbRG0FM5>; Fri, 27 Jul 2001 01:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268779AbRG0FMs>; Fri, 27 Jul 2001 01:12:48 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:14899 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S268778AbRG0FMg>; Fri, 27 Jul 2001 01:12:36 -0400
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: bitops.h ifdef __KERNEL__ cleanup.
In-Reply-To: <917E9842025@vcnet.vc.cvut.cz> <11472.995579612@redhat.com>
	<9j8bf1$1at$1@cesium.transmeta.com>
	<3B592427.96AFB00F@mandrakesoft.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 26 Jul 2001 23:05:57 -0600
In-Reply-To: <3B592427.96AFB00F@mandrakesoft.com>
Message-ID: <m1n15rdkqy.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Jeff Garzik <jgarzik@mandrakesoft.com> writes:

> > I think the idea with <asm/bitops.h> is that they are protected by
> > #ifdef __KERNEL__ if they are kernel-only; however, if they work in
> > user space then there is no #ifdef and autoconf can detect their
> > presence.
> 
> Any amount of sharing between userspace and kernel -adds- constraints to
> kernel code, and leads to namespace pollution on both ends by careless
> (or busy!) developers.
> 
> Let's remove restrictions and constraints from kernel code, not add to
> them...

Sounds reasonable.  Do you think you can get them to remove
/usr/include/linux, and, /usr/include/asm in the next release of Mandrake?

Eric
