Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276361AbRKCXzA>; Sat, 3 Nov 2001 18:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276535AbRKCXyl>; Sat, 3 Nov 2001 18:54:41 -0500
Received: from pizda.ninka.net ([216.101.162.242]:7296 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S276361AbRKCXyi>;
	Sat, 3 Nov 2001 18:54:38 -0500
Date: Sat, 03 Nov 2001 15:54:22 -0800 (PST)
Message-Id: <20011103.155422.74749787.davem@redhat.com>
To: rth@twiddle.net
Cc: csr21@cam.ac.uk, linux-kernel@vger.kernel.org
Subject: Re: SPARC and SA_SIGINFO signal handling
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011103115900.B5984@twiddle.net>
In-Reply-To: <20011031094342.A27520@cam.ac.uk>
	<20011031.021131.74751566.davem@redhat.com>
	<20011103115900.B5984@twiddle.net>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Richard Henderson <rth@twiddle.net>
   Date: Sat, 3 Nov 2001 11:59:00 -0800

   On Wed, Oct 31, 2001 at 02:11:31AM -0800, David S. Miller wrote:
   > The "register contents and so on" are in the sigcontext.
   > We don't use ucontext on sparc32.
   
   In other words, you don't support SA_SIGINFO at all.
   
Is it required?  All the information that thing provides is
determinable via other methods.

Franks a lot,
David S. Miller
davem@redhat.com
