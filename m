Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbRAOSo7>; Mon, 15 Jan 2001 13:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129485AbRAOSok>; Mon, 15 Jan 2001 13:44:40 -0500
Received: from smtp9.xs4all.nl ([194.109.127.135]:35837 "EHLO smtp9.xs4all.nl")
	by vger.kernel.org with ESMTP id <S129431AbRAOSoi>;
	Mon, 15 Jan 2001 13:44:38 -0500
Date: Mon, 15 Jan 2001 18:42:33 +0000
From: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, har
Message-ID: <20010115184233.A635@grobbebol.xs4all.nl>
In-Reply-To: <12A9B4484604@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <12A9B4484604@vcnet.vc.cvut.cz>; from VANDROVE@vc.cvut.cz on Mon, Jan 15, 2001 at 06:45:06PM +0000
X-OS: Linux grobbebol 2.4.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 15, 2001 at 06:45:06PM +0000, Petr Vandrovec wrote:
> I think that on BP6 hardware there is no way around except using 'noapic', 
> or passing board through Abit replacement program. There is only two bit 
> checksum which guards 8 or 22 data bits. I have no idea how frequent two 
> bits errors are, but, as your example shows, they definitely happen on 
> your hardware.

thanks for the explanation. I run noapic right now and didn't die yet. I
looked at the irq stuff and decided that I probably don't need it
anyways.

are there new(er) boards known that do not have this problem ?
(pls reply to bengel@grobbebol.xs4all.nl)

-- 
Grobbebol's Home                   |  Don't give in to spammers.   -o)
http://www.xs4all.nl/~bengel       | Use your real e-mail address   /\
Linux 2.2.16 SMP 2x466MHz / 256 MB |        on Usenet.             _\_v  
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
