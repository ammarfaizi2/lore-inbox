Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270676AbRHJW5k>; Fri, 10 Aug 2001 18:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270672AbRHJW5b>; Fri, 10 Aug 2001 18:57:31 -0400
Received: from zero.tech9.net ([209.61.188.187]:18696 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S270674AbRHJW5U>;
	Fri, 10 Aug 2001 18:57:20 -0400
Subject: Re: Remotely rebooting a machine with state 'D' processes, how?
From: Robert Love <rml@tech9.net>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <E15VL6x-0007Jm-00@gondolin.me.apana.org.au>
In-Reply-To: <E15VL6x-0007Jm-00@gondolin.me.apana.org.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99 (Preview Release)
Date: 10 Aug 2001 18:57:54 -0400
Message-Id: <997484288.688.9.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 Aug 2001 08:50:35 +1000, Herbert Xu wrote:
> Linus Torvalds <torvalds@transmeta.com> wrote:
> > In article <20010810231906.A21435@bonzo.nirvana> you write:
> 
> > You have to use the reboot() system call directly as root, with the
> > proper arguments to make it avoid doing even any sync. See
> 
> >        man 2 reboot
> 
> How do you do this when the process in the D state is holding the BKL?

the kernel should not sleep when it is holding the BKL (or any
semaphore).

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

