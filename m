Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282271AbRLQTGI>; Mon, 17 Dec 2001 14:06:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282222AbRLQTF6>; Mon, 17 Dec 2001 14:05:58 -0500
Received: from opengraphics.com ([216.208.162.194]:59652 "EHLO
	hurricane.opengraphics.com") by vger.kernel.org with ESMTP
	id <S282275AbRLQTFx>; Mon, 17 Dec 2001 14:05:53 -0500
Date: Mon, 17 Dec 2001 14:05:50 -0500
To: brain@artax.karlin.mff.cuni.cz
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with OSS driver and GUS PnP card
Message-ID: <20011217140550.H16621@opengraphics.com>
In-Reply-To: <Pine.LNX.4.30.0112170152450.770-100000@ghost.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0112170152450.770-100000@ghost.ucw.cz>
User-Agent: Mutt/1.3.18i
From: Len Sorensen <lsorense@opengraphics.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2001 at 02:10:28AM +0100, brain@artax.karlin.mff.cuni.cz wrote:
> Since kernel 2.2 I've got permanent problems with my Gravis Ultrasound PnP card
> and the OSS driver. The problem is following: /dev/dsp0 isn't able to
> play/record sound because of "IRQ/DMA conflict" messages. /dev/dsp1 is playing
> without problems, but it isn't able to record :-(
> 
> I have tried all possible settings of IO, IRQ and DMA. The problem persits. Can
> anybody help me? Can anybody explain me what does parameters io, irq, dma,
> dma16, gus16 and sb16 EXACTLY mean? The documentation is very poor and I'm not
> sure if it is io/irq/dma of the GF1 chip or of the "SB digital audio" (as in
> isapnp.conf). Is there any documentation on the gus driver?
> 
> Don't tell me to use Alsa. It's a piece of crap - the sound is very noisy, like
> a waterfall in background.

Hmm, I always use alsa for my GUS PnP card, since it has much better
support than the crappy old GUS driver in the kernel (and from OSS).
I don't actually use the card anymore since I got an SB Live instead,
but it used to work well.  The static hiss on the card is due to an IC
defect, and may be masked by the use of the GUS emulation, but I find
that hard to believe.  Also using the correct speed ram helps a lot
(70ns or faster).

Len Sorensen
