Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131503AbRBDMeh>; Sun, 4 Feb 2001 07:34:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131733AbRBDMe1>; Sun, 4 Feb 2001 07:34:27 -0500
Received: from CPE-61-9-150-57.vic.bigpond.net.au ([61.9.150.57]:27289 "EHLO
	elektra.higherplane.net") by vger.kernel.org with ESMTP
	id <S131503AbRBDMeI>; Sun, 4 Feb 2001 07:34:08 -0500
Date: Sun, 4 Feb 2001 23:43:52 +1100
From: john slee <indigoid@higherplane.net>
To: clock@atrey.karlin.mff.cuni.cz
Cc: linux-kernel@vger.kernel.org
Subject: Re: Inadmissible sound dropouts on 2.2.18
Message-ID: <20010204234352.D32071@higherplane.net>
In-Reply-To: <20010204120728.48319@ghost.btnet.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010204120728.48319@ghost.btnet.cz>; from clock@ghost.btnet.cz on Sun, Feb 04, 2001 at 12:07:28PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 04, 2001 at 12:07:28PM +0100, clock@ghost.btnet.cz wrote:
> The crackling is not dependent on the buffer size you can set up in the C code.
> The crackling is dependent on the frequency of the sine. It's clearly audible
> (read: annoying) at 10kHz, audible at 1kHz, inaudible at 100Hz. So I think
> they are sample dropouts - the card stops playing and repeats one sample until
> kernel gets the breath and whips itself up to supply next audio data.

hrm, i just ran your test progam. i don't hear this on my gus classic /
celeron 533 / 320mb ram.  at least nothing that *sounds* like crackling.
just a high pitched annoying noise.  using 2.4.1 + andrew morton's
lowlatency patches.  (which are wonderful, thanks andrew!)

jiggle the cable from the GUS to wherever it goes to.

j.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
