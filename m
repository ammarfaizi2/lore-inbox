Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288851AbSBIK5r>; Sat, 9 Feb 2002 05:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291913AbSBIK5h>; Sat, 9 Feb 2002 05:57:37 -0500
Received: from smtp-out-6.wanadoo.fr ([193.252.19.25]:23237 "EHLO
	mel-rto6.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S288845AbSBIK5Z>; Sat, 9 Feb 2002 05:57:25 -0500
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@transmeta.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Ingo Molnar <mingo@elte.hu>, Alexander Viro <viro@math.psu.edu>,
        Andrew Morton <akpm@zip.com.au>, Martin Wirth <Martin.Wirth@dlr.de>,
        Robert Love <rml@tech9.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        haveblue <haveblue@us.ibm.com>
Subject: Re: [RFC] New locking primitive for 2.5
Date: Fri, 8 Feb 2002 22:40:12 +0100
Message-Id: <20020208214012.26611@smtp.wanadoo.fr>
In-Reply-To: <3C642F52.ABD14619@mandrakesoft.com>
In-Reply-To: <3C642F52.ABD14619@mandrakesoft.com>
X-Mailer: CTM PowerMail 3.1.1 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Are there architectures out there that absolutely must implement this
>with a spinlock?  Your suggested API of functions to read/write 64-bit
>values atomically would work for such a case, but still I am just
>curious.

At least PPC32 can't do that without a spinlock_irq

Ben.


