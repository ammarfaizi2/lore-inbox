Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129112AbRCTOMv>; Tue, 20 Mar 2001 09:12:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129126AbRCTOMl>; Tue, 20 Mar 2001 09:12:41 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:36462 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S129112AbRCTOM2>; Tue, 20 Mar 2001 09:12:28 -0500
Date: Tue, 20 Mar 2001 08:11:12 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: Alessandro Suardi <alessandro.suardi@oracle.com>
cc: Linux-Kernel <linux-kernel@vger.kernel.org>, tytso@mit.edu,
        guthrie@infonautics.com
Subject: Re: PCMCIA serial CardBus support vanished in 2.4.3-pre3 and later
In-Reply-To: <3AB759F4.F9F5F35D@oracle.com>
Message-ID: <Pine.LNX.3.96.1010320080638.18764C-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Mar 2001, Alessandro Suardi wrote:
> Jeff Garzik wrote:
> > Neither.  serial.c does serial_cb's job now.  It looks like serial.c
> > needs to scan for modems as well as serial ports, and tytso agrees with
> > me on that.  We just need to check and see if winmodems reports
> > themselves as real modems before fixing this.

> OK, thanks. I assume you mean "serial.c should do serial_cb's job now",
>  since it doesn't :) If you want me to test patches etc. just let me know.

Re-CC'd to linux-kernel, hope you don't mind.

Anyone interested in testing patches, this simple change is what needs
testing on various PCI and CardBus modems:
http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg34097.html
(since it's a web archive, you may have to hack the patch in manually...)

It seems straightforward enough, and both tytso and I think the change
is ok, but (at tytso's suggestion) I'm going to test some various
winmodem and other use cases because assuring ourselves that it is good
enough for a general rule...

Regards,

	Jeff



