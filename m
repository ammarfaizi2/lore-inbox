Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130145AbRBMAZH>; Mon, 12 Feb 2001 19:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130195AbRBMAY5>; Mon, 12 Feb 2001 19:24:57 -0500
Received: from red.csi.cam.ac.uk ([131.111.8.70]:44504 "EHLO red.csi.cam.ac.uk")
	by vger.kernel.org with ESMTP id <S130145AbRBMAYl>;
	Mon, 12 Feb 2001 19:24:41 -0500
Date: Tue, 13 Feb 2001 00:24:08 +0000 (GMT)
From: James Sutherland <jas88@cam.ac.uk>
To: "H. Peter Anvin" <hpa@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Werner Almesberger <Werner.Almesberger@epfl.ch>,
        linux-kernel@vger.kernel.org
Subject: Re: LILO and serial speeds over 9600
In-Reply-To: <3A8876FA.EA2034D1@transmeta.com>
Message-ID: <Pine.SOL.4.21.0102130020440.18655-100000@red.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Feb 2001, H. Peter Anvin wrote:

> James Sutherland wrote:
> > >
> > > Depends on what the client can handle.  For the kernel, that might be
> > > true, but for example a boot loader may only have a few K worth of buffer
> > > space.
> > 
> > Fortunately, the bulky stuff (printk's from the booting kernel) will be
> > going from the boot loader to the server, and should be buffered there
> > OK until they can be processed. Only the stuff sent to the client will
> > need buffering, and that should be simple keystrokes...
> 
> Well, any time there is a network there needs to be buffering, if you
> want to have any kind of ACK protocol.

Yes, but only the last packet sent, if you limit to one packet at a
time... Shouldn't be a problem, even for the smallest code.


James.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
