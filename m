Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129227AbQKNRvK>; Tue, 14 Nov 2000 12:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130201AbQKNRvB>; Tue, 14 Nov 2000 12:51:01 -0500
Received: from grad.physics.sunysb.edu ([129.49.56.86]:46349 "EHLO
	grad.physics.sunysb.edu") by vger.kernel.org with ESMTP
	id <S129227AbQKNRuu>; Tue, 14 Nov 2000 12:50:50 -0500
Date: Tue, 14 Nov 2000 12:20:19 -0500 (EST)
From: Rui Sousa <rsousa@grad.physics.sunysb.edu>
To: Hans Grobler <grobh@sun.ac.za>
cc: "Willis L. Sarka" <wlsarka@the-republic.org>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] Hard lockup using emu10k1-based sound card
In-Reply-To: <Pine.LNX.4.21.0011132009020.6877-100000@ccs.sun.ac.za>
Message-ID: <Pine.LNX.4.21.0011141216450.18636-100000@grad.physics.sunysb.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Nov 2000, Hans Grobler wrote:

> On Mon, 13 Nov 2000, Willis L. Sarka wrote:
> > I get a hard lockup when trying to play a mp3 with XMMS;
> > Sound Blaster Live card.  The first second loops, and I lose all
> > connectivity to the machine; I can't ping it, can't to a an Alt-Sysq,
> > nothing.
> 
> Just for reference, I've been use the ALSA drivers for most of the
> 2.4.0-testX kernels without any problems (provided you use the driver
> version that matches the kernel version). Even under high memory
> preasure, swapping, NFS traffic, etc. the worst that happens is sporadic
> skipping. XMMS and mpg123 in use. I've tried the kernel emu10k1 a few
> times but also got similar lockup's.

Which was the latest kernel you tried? A (easy to trigger) deadlock was
fixed around 2.4.0-test...

Rui Sousa

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
