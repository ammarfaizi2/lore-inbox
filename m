Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268974AbRHWQw2>; Thu, 23 Aug 2001 12:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269081AbRHWQwH>; Thu, 23 Aug 2001 12:52:07 -0400
Received: from ffke-campus-gw.mipt.ru ([194.85.82.65]:40322 "EHLO
	www.2ka.mipt.ru") by vger.kernel.org with ESMTP id <S268974AbRHWQwC>;
	Thu, 23 Aug 2001 12:52:02 -0400
Message-Id: <200108231653.f7NGrOl32250@www.2ka.mipt.ru>
Date: Thu, 23 Aug 2001 20:56:02 +0400
From: Evgeny Polyakov <johnpol@2ka.mipt.ru>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] this patch add a possibility to add a random offset to the stack on exec.
In-Reply-To: <E15ZttT-0003kI-00@the-village.bc.nu>
In-Reply-To: <200108230130.f7N1Uol14698@www.2ka.mipt.ru>
	<E15ZttT-0003kI-00@the-village.bc.nu>
Reply-To: johnpol@2ka.mipt.ru
X-Mailer: stuphead ver. 0.5.3 (Wiskas) (GTK+ 1.2.7; Linux 2.4.9; i686)
Organization: MIPT
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On Thu, 23 Aug 2001 13:47:31 +0100 (BST)
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

>> "Add a possibility to add a random offset to the stack on exec. This
makes
>> it slightly harder to write generic buffer overflows. This doesn't
really
>> give any real security, but it raises the bar for script-kiddies and
it's
>> really cheap."

AC> Its so slight its useless, and the randomness makes it hard to verify
AC> you
AC> fixed a problem. Remember once an exploit appears a box will get
scanned
AC> hundreds of times - someone will get the right offset 8)

You want to tell, that running 2 process one directky after another( like
exploits do),
and esp will be the same, even with random addition? It's impossible.

But i quite understand your position in this question :(.

AC> There is another good reason for offseting stacks within the page -
AC> especially the kernel stacks which is to avoid things like each apache
AC> task sleeping with wait queues on the same cache colour

---
WBR. //s0mbre
