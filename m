Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262022AbUDCXE7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 18:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262027AbUDCXE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 18:04:59 -0500
Received: from [24.80.50.208] ([24.80.50.208]:18444 "EHLO gw.sieb.net")
	by vger.kernel.org with ESMTP id S262022AbUDCXE6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 18:04:58 -0500
Message-ID: <406F42D8.4010301@sieb.net>
Date: Sat, 03 Apr 2004 15:03:52 -0800
From: Samuel Sieb <samuel@sieb.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040321
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Aubin LaBrosse <arl8778@rit.edu>
Cc: linux-kernel@vger.kernel.org, linux-pcmcia@lists.infradead.org
Subject: Re: pc card hangs computer with 2.6 kernel (more details)
References: <406E2392.2090804@sieb.net> <1080963939.7055.159.camel@rain.rh.rit.edu>
In-Reply-To: <1080963939.7055.159.camel@rain.rh.rit.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aubin LaBrosse wrote:

>  On Fri, 2004-04-02 at 21:38, Samuel Sieb wrote:
>
> > I sent this originally to the pcmcia list, but haven't seen a
> > response yet.
> >
> > My laptop freezes as soon as I insert a Linksys WPC11 card which is
> > an 802.11b wireless card. I don't think it's the driver since as
> > far as I can tell, the drivers aren't included in the kernel (it's
> > a prism 2). I first tried with a 2.6.1 kernel and then upgraded to
> > 2.6.4 but it still acts the same. (I'm using Fedora Core Testing,
> > updated to latest.)
> >
> > The laptop is a Compaq Presario 2190
>
>
>  I had similar issues with an hp laptop which was running fedora at
>  the time. It turns out to be the fedora pcmcia config vs the laptop.
>  You can try this /etc/pcmcia/config.opts file, originally posted by
>  Mathieu Lesniak (Thanks Mathieu!) in response to my issue - it forces
>  pcmcia to use a specific irq and memory range, and it Worked For Me
>  (tm)
>
>  --aubin

Thank you very much!  (I'm sending this wirelessly.)
It did take IRQ 10 even though it was excluded in the config file.  But 
it works, so it was either a port issue or memory issue.  I'll try to 
narrow it down if I get a chance.

