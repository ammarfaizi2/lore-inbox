Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264680AbRGCOya>; Tue, 3 Jul 2001 10:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264564AbRGCOyU>; Tue, 3 Jul 2001 10:54:20 -0400
Received: from [64.64.109.142] ([64.64.109.142]:29709 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S264680AbRGCOyM>; Tue, 3 Jul 2001 10:54:12 -0400
Message-ID: <3B41DC8D.3316A7A8@didntduck.org>
Date: Tue, 03 Jul 2001 10:54:05 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Guillaume Lancelin <guillaumelancelin@yahoo.es>
CC: linux-kernel@vger.kernel.org
Subject: Re: Memory access
In-Reply-To: <20010703144532.11007.qmail@web4201.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guillaume Lancelin wrote:
> 
> Writing a device driver for a IO card, I have the following message from
> the kernel:
> Unable to handle kernel paging request at virtual address 000d0804.
> [then it gives the register values]
> Segmentation fault."
> 
> This address (0xd0804) is the location of a "mailbox" reserved by the IO
> card, and from which commands are passed to the card.
> 
> My question: is the kernel using or protecting this area of the memory,
> and is there a way to deprotect it??? (how dangerous!)

Use ioremap()

--

				Brian Gerst
