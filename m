Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129675AbRAESah>; Fri, 5 Jan 2001 13:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129773AbRAESa3>; Fri, 5 Jan 2001 13:30:29 -0500
Received: from gnu.in-berlin.de ([192.109.42.4]:38159 "EHLO gnu.in-berlin.de")
	by vger.kernel.org with ESMTP id <S129675AbRAESaS>;
	Fri, 5 Jan 2001 13:30:18 -0500
X-Envelope-From: kraxel@goldbach.in-berlin.de
Date: Fri, 5 Jan 2001 18:33:44 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bryan Mayland <bmayland@leoninedev.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] VESA framebuffer w/ MTRR locks 2.4.0 on init
Message-ID: <20010105183344.A2445@goldbach.in-berlin.de>
In-Reply-To: <3A55FAC9.9EB4C967@leoninedev.com> <E14Ea7x-00081J-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <E14Ea7x-00081J-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Jan 05, 2001 at 04:54:03PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> yywrap is a hack rather than generally safe feature and its not guaranteed that
> your videoram wraps neatly. Really the driver should have spotted the hole I
> guess.

Well, vesafb really depends on what the vesa bios says...

That's why it has all may-have-problems features turned off by default:
no ywrap, no mtrr.  At least it was this way last time I touched it.

  Gerd

-- 
Get back there in front of the computer NOW. Christmas can wait.
	-- Linus "the Grinch" Torvalds,  24 Dec 2000 on linux-kernel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
