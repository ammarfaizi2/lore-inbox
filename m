Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131495AbRA3BIT>; Mon, 29 Jan 2001 20:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131693AbRA3BIJ>; Mon, 29 Jan 2001 20:08:09 -0500
Received: from mailgate.rz.uni-karlsruhe.de ([129.13.64.97]:18438 "EHLO
	mailgate.rz.uni-karlsruhe.de") by vger.kernel.org with ESMTP
	id <S131495AbRA3BH5>; Mon, 29 Jan 2001 20:07:57 -0500
To: mdiehlcs@compuserve.de, torvalds@transmeta.com
Cc: jgarzik@mandrakesoft.mandrakesoft.com, linux-kernel@vger.kernel.org
Subject: Re: PCI IRQ routing problem in 2.4.0 (updated patch)
From: Robert Siemer <Robert.Siemer@gmx.de>
In-Reply-To: <Pine.LNX.4.21.0101291859220.29065-100000@notebook.diehl.home>
In-Reply-To: <Pine.LNX.4.10.10101290928060.9131-100000@penguin.transmeta.com>
	<Pine.LNX.4.21.0101291859220.29065-100000@notebook.diehl.home>
X-Mailer: Mew version 1.94b25 on Emacs 20.5 / Mule 4.0 (HANANOEN)
Reply-To: Robert Siemer <siemer@panorama.hadiko.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20010130020746C.siemer@panorama.hadiko.de>
Date: Tue, 30 Jan 2001 02:07:46 +0100
X-Dispatcher: imput version 990425(IM115)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Diehl <mdiehlcs@compuserve.de>
> On Mon, 29 Jan 2001, Linus Torvalds wrote:

> Below is the updated patch. It should handle both (0x01/0x41
> like) mappings. I can (and did) only test the 0x01 case.
> USBIRQ routing (0x62) supported, IDE/ACPI/DAQ untouched.

I don't really understand your note above, but your patch alone does
not fix my problem. - Linus diff over pci-irq.c does.

The kernel still does not think what the bios states; it's like the
vanilla 2.4.0 in this regard. (--> on my box: kernel panic after
"modprobe usb-ohci && modprobe hid")


Bye,
	Robert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
