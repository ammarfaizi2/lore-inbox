Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285692AbSAZBYr>; Fri, 25 Jan 2002 20:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288975AbSAZBYh>; Fri, 25 Jan 2002 20:24:37 -0500
Received: from ns.suse.de ([213.95.15.193]:44817 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S285692AbSAZBYS>;
	Fri, 25 Jan 2002 20:24:18 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] syscall latency improvement #1
In-Reply-To: <18993.1011984842@warthog.cambridge.redhat.com.suse.lists.linux.kernel> <Pine.LNX.4.33.0201251626490.2042-100000@penguin.transmeta.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 26 Jan 2002 02:24:16 +0100
In-Reply-To: Linus Torvalds's message of "26 Jan 2002 01:56:44 +0100"
Message-ID: <p73y9il7vlr.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> Looking at the code, I suspect that 99.9% of this "improvement" comes from
> one thing, and one thing only: you removed the "cli" in the system call
> return path.

It doesn't explain the Athlon speedups. On athlon cli is ~4 cycles. 

-Andi
