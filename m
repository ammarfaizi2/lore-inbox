Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280129AbRJaKLX>; Wed, 31 Oct 2001 05:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280130AbRJaKLN>; Wed, 31 Oct 2001 05:11:13 -0500
Received: from pizda.ninka.net ([216.101.162.242]:21120 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S280129AbRJaKK6>;
	Wed, 31 Oct 2001 05:10:58 -0500
Date: Wed, 31 Oct 2001 02:11:31 -0800 (PST)
Message-Id: <20011031.021131.74751566.davem@redhat.com>
To: csr21@cam.ac.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: SPARC and SA_SIGINFO signal handling
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011031094342.A27520@cam.ac.uk>
In-Reply-To: <20011029190027.A21372@cam.ac.uk>
	<20011030.125134.93645850.davem@redhat.com>
	<20011031094342.A27520@cam.ac.uk>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Christophe Rhodes <csr21@cam.ac.uk>
   Date: Wed, 31 Oct 2001 09:43:43 +0000

   However, what I don't see to get at is the usercontext/ucontext
   structure containing register contents and so on, which as far as I am
   aware should be in the third (data) argument to the sa_sigaction-type
   sighandler; that's where I'm getting my problems.

The "register contents and so on" are in the sigcontext.
We don't use ucontext on sparc32.

Franks a lot,
David S. Miller
davem@redhat.com
