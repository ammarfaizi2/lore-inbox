Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131544AbRBBAJz>; Thu, 1 Feb 2001 19:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132120AbRBBAJo>; Thu, 1 Feb 2001 19:09:44 -0500
Received: from smtp8.xs4all.nl ([194.109.127.134]:31943 "EHLO smtp8.xs4all.nl")
	by vger.kernel.org with ESMTP id <S131544AbRBBAJY>;
	Thu, 1 Feb 2001 19:09:24 -0500
Date: Thu, 1 Feb 2001 23:18:06 +0000
From: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
To: Mark Orr <markorr@intersurf.com>
Cc: miquels@cistron.nl, arobinso@nyx.net, linux-kernel@vger.kernel.org
Subject: Re: esp causing crashes..
Message-ID: <20010201231806.B2684@grobbebol.xs4all.nl>
In-Reply-To: <20010129175752.A657@grobbebol.xs4all.nl> <XFMail.20010201153828.markorr@intersurf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <XFMail.20010201153828.markorr@intersurf.com>; from markorr@intersurf.com on Thu, Feb 01, 2001 at 03:38:28PM -0600
X-OS: Linux grobbebol 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 01, 2001 at 03:38:28PM -0600, Mark Orr wrote:
> I dont like to be the sort of person who, when people report problems,
> fires back "it works fine here!"...but...just as a point of reference,
> I have a Hayes ESP too -- it's connected to a 56k modem.  I havent
> had any crashes or hangs related to it, but I dont use mgetty.  (I use
> rungetty, a variant of mingetty,  for VC's).    Seeing this, I will
> compile up mgetty here to see if I can replicate it.


even without mgetty it fails. the fact hat esp.o is loaded is cause for
trouble. minicom using the card, exit - crash.

I do not use the DMA channel of the card as it conflicts with the SB16 I
have on board.

-- 
Grobbebol's Home                   |  Don't give in to spammers.   -o)
http://www.xs4all.nl/~bengel       | Use your real e-mail address   /\
Linux 2.2.16 SMP 2x466MHz / 256 MB |        on Usenet.             _\_v  
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
