Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129345AbQLBQkk>; Sat, 2 Dec 2000 11:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129707AbQLBQka>; Sat, 2 Dec 2000 11:40:30 -0500
Received: from [66.30.136.189] ([66.30.136.189]:25354 "HELO
	kullstam.ne.mediaone.net") by vger.kernel.org with SMTP
	id <S129345AbQLBQkR>; Sat, 2 Dec 2000 11:40:17 -0500
From: "Johan Kullstam" <kullstam@ne.mediaone.net>
To: linux-kernel@vger.kernel.org
Subject: Re: multiprocessor kernel problem
In-Reply-To: <3A27D4D6.4DA47346@lanl.gov>
Organization: none
Date: 02 Dec 2000 11:12:19 -0500
In-Reply-To: Roger Crandell's message of "Fri, 01 Dec 2000 09:41:58 -0700"
Message-ID: <m2y9xy4xb0.fsf@euler.axel.nom>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roger Crandell <rwc@lanl.gov> writes:

> I have 2.4.0  test 10 and test 11 installed on a multiprocessor (Intel)
> machine.  I have tried both test versions of the kernel.  I configured
> the kernel for single
> and multi processor.  When I boot single processor, iptables will run
> fine.  When I boot the machine with the multiprocessor kernel and run
> iptables, the kernel dumps several pages of hex and the final two lines
> of output are:
> 
> Killing interrupt handler
> scheduling in interrupt
> 
> The kernel logs nothing and you must reset the machine to bring it back
> up.  I believe this is a kernel issue rather than an iptables
> issue.
> 
> Does anyone have experience with iptables on a multiprocessor
> machine?

i tried it about a month back with -test11.  my quad ppro simply
locked up and died when i issued "iptables -nL".  i got no logs just a
freeze.  perhaps only my keyboard mouse and NIC died and the rest of
the machine kept on running.  i posted a couple of times to the
netfilter mailing list but got zero response.

-- 
J o h a n  K u l l s t a m
[kullstam@ne.mediaone.net]
Don't Fear the Penguin!
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
