Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262682AbRFYInY>; Mon, 25 Jun 2001 04:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262685AbRFYInE>; Mon, 25 Jun 2001 04:43:04 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:42057 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S262682AbRFYInA>; Mon, 25 Jun 2001 04:43:00 -0400
To: David Lang <david.lang@digitalinsight.com>
Cc: John Nilsson <pzycrow@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Some experience of linux on a Laptop
In-Reply-To: <Pine.LNX.4.33.0106242308100.7535-100000@dlang.diginsite.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 25 Jun 2001 02:38:22 -0600
In-Reply-To: <Pine.LNX.4.33.0106242308100.7535-100000@dlang.diginsite.com>
Message-ID: <m1u2159cox.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang <david.lang@digitalinsight.com> writes:

> if you don't preserve things running in userspace what advantage do you
> have over rebooting?

I use it as part of a bootloader.  Allowing me to boot one kernel
directly from another.   I guess it really is a soft reboot that never
touches any BIOS.  I don't know if anyone else would get value from it.
 
> if you do preserve userspace stuff then you need to also preserve the
> kernel state related to each user process (including network connections,
> etc), and here you are back into the problem that the kernel structures
> may change on you.

Preserving userspace without out any help from user space is quite
a tricky business.  Though with user space help it is fully doable
though it may be a lot of work.

What I have doesn't address perserving user space.  I offered because
I didn't know what was wanted.  An easy kernel upgrade without touching
running processes or a just a fast way to get into a new kernel.

Eric
