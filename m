Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279029AbRKIB0G>; Thu, 8 Nov 2001 20:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279003AbRKIBZ5>; Thu, 8 Nov 2001 20:25:57 -0500
Received: from freeside.toyota.com ([63.87.74.7]:39178 "EHLO toyota.com")
	by vger.kernel.org with ESMTP id <S279029AbRKIBZr>;
	Thu, 8 Nov 2001 20:25:47 -0500
Message-ID: <3BEB3092.7DC835B3@lexus.com>
Date: Thu, 08 Nov 2001 17:25:38 -0800
From: J Sloan <jjs@lexus.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: volodya@mindspring.com
CC: erasmo perez <erasmo@aztlan.fb10.tu-berlin.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Loopback device support, kernel 2.4.14, can not compile ?
In-Reply-To: <Pine.LNX.4.20.0111082005150.9843-100000@node2.localnet.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

volodya@mindspring.com wrote:

> On Fri, 9 Nov 2001, erasmo perez wrote:
>
> > hello
> >
> > i think i have found an error in the kernel, i think ...
> >
> > when a i try to compile the 2.4.14 with the option:
> >
> > Loopback device support
>
> Get 2.4.15-pre1 patch - it fixes this.

Yes, 2.4.15-pre1 fixes that, and somewhat works -

However 2.4.15-pre1 has some other issues.

For instance, in 2.4.15-pre1, I can reliably hang
my machine with the following simple command,
as a non-root user:

ssh localhost

Is that bizzare or what? I've never seen
that type of bug in Linux before -

cu

jjs


