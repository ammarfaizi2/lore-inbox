Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130674AbRBLMPQ>; Mon, 12 Feb 2001 07:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130677AbRBLMPH>; Mon, 12 Feb 2001 07:15:07 -0500
Received: from red.csi.cam.ac.uk ([131.111.8.70]:33971 "EHLO red.csi.cam.ac.uk")
	by vger.kernel.org with ESMTP id <S130674AbRBLMOy>;
	Mon, 12 Feb 2001 07:14:54 -0500
Date: Mon, 12 Feb 2001 12:14:07 +0000 (GMT)
From: James Sutherland <jas88@cam.ac.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andi Kleen <freitag@alancoxonachip.com>, linux-kernel@vger.kernel.org
Subject: Re: [OT] Major Clock Drift
In-Reply-To: <E14SFwF-0006ay-00@the-village.bc.nu>
Message-ID: <Pine.SOL.4.21.0102121212400.24003-100000@red.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Feb 2001, Alan Cox wrote:

> > > 			queued_writes=1;
> > > 			return;
> > 
> > Just what happens when you run out of dmesg ring in an interrupt ?
> 
> You lose a couple of lines. Big deal. I'd rather lose two lines a year on
> a problem (and the dmesg ring buffer is pretty big) than two minutes an hour
> every hour for the entire running life of the machine

Also, you should know when the ring overflows, and be able to indicate
this: it will be clear when and where messages were lost?


James.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
