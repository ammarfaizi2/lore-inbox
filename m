Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130750AbQLDAuh>; Sun, 3 Dec 2000 19:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130901AbQLDAub>; Sun, 3 Dec 2000 19:50:31 -0500
Received: from [66.30.136.189] ([66.30.136.189]:1800 "HELO
	kullstam.ne.mediaone.net") by vger.kernel.org with SMTP
	id <S130750AbQLDAuT>; Sun, 3 Dec 2000 19:50:19 -0500
From: "Johan Kullstam" <kullstam@ne.mediaone.net>
To: linux-kernel@vger.kernel.org
Subject: Re: multiprocessor kernel problem
In-Reply-To: <20001203020904.31A2C813F@halfway.linuxcare.com.au>
Organization: none
Date: 03 Dec 2000 19:22:21 -0500
In-Reply-To: Rusty Russell's message of "Sun, 03 Dec 2000 13:08:53 +1100"
Message-ID: <m2elzp3uiq.fsf@euler.axel.nom>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell <rusty@linuxcare.com.au> writes:

> In message <3A27D4D6.4DA47346@lanl.gov> you write:
> > 
> > I have 2.4.0  test 10 and test 11 installed on a multiprocessor (Intel)
> > machine.  I have tried both test versions of the kernel.  I configured
> > the kernel for single
> > and multi processor.  When I boot single processor, iptables will run
> > fine.  When I boot the machine with the multiprocessor kernel and run
> > iptables, the kernel dumps several pages of hex and the final two lines
> > of output are:
> > 
> > Killing interrupt handler
> > scheduling in interrupt
> 
> My development box (running test10pre5) is SMP, and it works fine.

yes, but is it a dual machine or is it an N-way SMP with N > 2?  the
other guy with iptables/SMP problems also has a quad box.  could this
perhaps be a problem only when you have more than two processors?

> I
> haven't updated to the latest kernel version because I like my
> filesystems in one piece, and the netfilter code hasn't changed.
> 
> What is your kernel configuration, and iptables version?  Have you
> patched the kernel?

i tried 2.4.0-test10 (no patches) with iptables 1.1.2.  this is an alr
revolution quad6 (4 ppros).

i posted this to the netfilter mailing list a while back.
<URL:http://lists.samba.org/pipermail/netfilter/2000-November/005838.html>

-- 
J o h a n  K u l l s t a m
[kullstam@ne.mediaone.net]
Don't Fear the Penguin!
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
