Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030262AbVKVX4y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030262AbVKVX4y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 18:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030265AbVKVX4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 18:56:54 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:48393 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030262AbVKVX4x convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 18:56:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AYJlQJH1aScUu3METbYzzdQqQWp5yQk+igoStIEuVnbEGJVSyuvpMKnEMHaH7xgAHY8uOzRmdJS4TokQMgRPft7nWXfyYF3rgjAk29K9RE9d39kNe7Fm2hSIQqvKmSinQcY9gpRJgy0nFsW9J3Y8Y4x1sVDbAc5WijAxe0uoxi4=
Message-ID: <9e4733910511221556n1fe390e5qcd778f39aa75695d@mail.gmail.com>
Date: Tue, 22 Nov 2005 18:56:30 -0500
From: Jon Smirl <jonsmirl@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Christmas list for the kernel
Cc: Kasper Sandberg <lkml@metanurb.dk>, Greg KH <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1132702614.20233.91.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9e4733910511221031o44dd90caq2b24fbac1a1bae7b@mail.gmail.com>
	 <20051122204918.GA5299@kroah.com>
	 <9e4733910511221313t4a1e3c67wc7b08160937eb5c5@mail.gmail.com>
	 <1132694935.10574.2.camel@localhost>
	 <9e4733910511221341u695f6765k985ecf0c54daba49@mail.gmail.com>
	 <1132702614.20233.91.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Maw, 2005-11-22 at 16:41 -0500, Jon Smirl wrote:
> > An example of this is that the serial driver is hard coded to report
> > four legacy serial ports when my system physically only has two. I
> > have to change a #define and recompile the kernel to change this.
>
> It does an autodetect sequence to find the ports. If it reports ttyS0-S3
> your system probably has them, they may just not be wired to external
> ports and that is kinda tricky to autodetect

The ports really aren't there. If we had a driver for the LPC chip it
would see that the chip only implemented two ports.  On modern
hardware a driver for LPC/super IO chips might be enough to do all of
the needed legacy detection.


>
> > looks for everything again anyway. In a more friendly system X would
> > use the info the kernel provides and automatically configure itself
> > for the devices present or hotplugged. You could get rid of your
> > xorg.cong file in this model.
>
>
> Not really as half of xorg.conf is preferences
>
>


--
Jon Smirl
jonsmirl@gmail.com
