Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289991AbSAKPuS>; Fri, 11 Jan 2002 10:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289993AbSAKPuI>; Fri, 11 Jan 2002 10:50:08 -0500
Received: from colorfullife.com ([216.156.138.34]:57352 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S289991AbSAKPuA>;
	Fri, 11 Jan 2002 10:50:00 -0500
Message-ID: <3C3F09AC.8EC143E2@colorfullife.com>
Date: Fri, 11 Jan 2002 16:50:04 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.2-pre9 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Matthew Kirkwood <matthew@hairy.beasts.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] Lightweight user-level semaphores
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Actually, the more I look at Linus's original idea, the more
> sense it seems to make (and the more I regret scrapping my
> almost-complete implementation of it for the fd idea :)

Do you have a plan how to implement the no-contention case entirely in
userspace?
That would make them really fast, not just saving 50 or 100 cycles
through a special syscall and bypassing VFS.

--
	Manfred
