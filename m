Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264673AbRGCO5K>; Tue, 3 Jul 2001 10:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264564AbRGCO4u>; Tue, 3 Jul 2001 10:56:50 -0400
Received: from zeke.inet.com ([199.171.211.198]:45043 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id <S264769AbRGCO4j>;
	Tue, 3 Jul 2001 10:56:39 -0400
Message-ID: <3B41DD18.A7E5860F@inet.com>
Date: Tue, 03 Jul 2001 09:56:24 -0500
From: Eli Carter <eli.carter@inet.com>
Organization: Inet Technologies, Inc.
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.5-15 i686)
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

Sounds like you may want to look into ioremap() and maybe buy Linux
Device Drivers by Rubini (O'Reilly).

Have fun!

Eli 
-----------------------.   No wonder we didn't get this right first time
Eli Carter             |      through. It's not really all that horribly 
eli.carter(at)inet.com `- complicated, but the _details_ kill you. Linus
