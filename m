Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132551AbRDQF32>; Tue, 17 Apr 2001 01:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132552AbRDQF3T>; Tue, 17 Apr 2001 01:29:19 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:21599 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S132551AbRDQF27>; Tue, 17 Apr 2001 01:28:59 -0400
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Patrick Shirkey <pshirkey@boosthardware.com>, linux-kernel@vger.kernel.org
Subject: Re: Files not linking/replacing.
In-Reply-To: <3ADA524A.7038A81C@boosthardware.com> <m1eluttkx2.fsf@frodo.biederman.org> <3ADA949C.D10D8536@mandrakesoft.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 16 Apr 2001 23:27:25 -0600
In-Reply-To: Jeff Garzik's message of "Mon, 16 Apr 2001 02:43:40 -0400"
Message-ID: <m14rvot7sy.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@mandrakesoft.com> writes:

> "Eric W. Biederman" wrote:
> > Normally /usr/src/linux on a redhat system contains a kernel with a
> > known good set of kernel headers.  /usr/include/linux and
> > /usr/include/asm are symlinks that point into the known good kernel
> > headers.  It looks like you removed your known good 2.2.14 known good
> > kernel headers, or the symlinks to them.
> 
> Modern glibc systems have their own copies of headers for
> /usr/include/{asm,linux}, and those locations should not be pointing to
> kernel space...

I keep thinking that until I look at what has actually been installed.
The quickest way I know to confuse a compile is: rm /usr/src/linux.

Eric
