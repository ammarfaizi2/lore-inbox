Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129657AbQKHR7A>; Wed, 8 Nov 2000 12:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129488AbQKHR6u>; Wed, 8 Nov 2000 12:58:50 -0500
Received: from fs1.dekanat.physik.uni-tuebingen.de ([134.2.216.20]:50698 "EHLO
	fs1.dekanat.physik.uni-tuebingen.de") by vger.kernel.org with ESMTP
	id <S129657AbQKHR6h>; Wed, 8 Nov 2000 12:58:37 -0500
Date: Wed, 8 Nov 2000 18:58:23 +0100 (CET)
From: Richard Guenther <richard.guenther@student.uni-tuebingen.de>
To: James Simmons <jsimmons@suse.com>
cc: Richard Guenther <richard.guenther@student.uni-tuebingen.de>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, tytso@mit.edu,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Broken colors on console with 2.4.0-textXX
In-Reply-To: <Pine.LNX.4.21.0011080952570.2704-100000@euclid.oak.suse.com>
Message-ID: <Pine.LNX.4.21.0011081856460.17375-100000@fs1.dekanat.physik.uni-tuebingen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Nov 2000, James Simmons wrote:

> 
> > Okay - so its the console subsystem that gets it wrong? Remember
> > that 2.2.X gets it right - with the same X server. I really
> > would like to have this fixed in 2.4 - can I do something to
> > help fixing this? (I'm not familiar with the console subsystem,
> > neither with the X server)
> 
> It is the way it is done that is wrong. At present the X server is in
> total control of setting the console system back to text mode. This
> works under normal conditions but when the system is stressed or X
> fails you are stuck. The console system should be setting the video
> hardware back to vga text mode instead of the X server. I have been
> working on a patch that does that. 

Sure - but this was always the case. And using 2.2 with the same
(or more) stress the Xserver is still able to set the video hardware
back to vga text mode. I just want to know whats the difference
between 2.2 and 2.4 that causes failure in 2.4.

Richard.

--
Richard Guenther <richard.guenther@student.uni-tuebingen.de>
WWW: http://www.anatom.uni-tuebingen.de/~richi/
The GLAME Project: http://www.glame.de/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
