Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262701AbTDMBnx (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 21:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262736AbTDMBnx (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 21:43:53 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:8372 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262701AbTDMBnw (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 12 Apr 2003 21:43:52 -0400
Subject: Re: 2.5.67-mm2
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Andrew Morton <akpm@digeo.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
In-Reply-To: <20030412180852.77b6c5e8.akpm@digeo.com>
References: <20030412180852.77b6c5e8.akpm@digeo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1050198928.597.6.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 13 Apr 2003 03:55:29 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-04-13 at 03:08, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.67/2.5.67-mm2/
> 
> . Lots of misc saved-up things.
> 
> . I've changed the 32-bit dev_t patch to provide a 12:20 split rather than
>   16:16.  This patch is starting to drag a bit and unless someone stops me I
>   might just go submit the thing.

Any patches for CardBus/PCMCIA support? It's broken for me since
2.5.66-mm2 (it works with 2.5.66-mm1) probably due to PCI changes or the
new PCMCIA state machine: if I boot my machine with my 3Com CardBus NIC
plugged in, the kernel deadlocks while checking the sockets, but it
works when booting with the card unplugged, and then plugging it back
once the system is stable (for example, init 1).

I have written to Russell King, but had no response from him. Maybe he
is too busy. I'm stuck at 2.5.66-mm1 on my laptop.

-- 
Please AVOID sending me WORD, EXCEL or POWERPOINT attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html
Linux Registered User #287198

