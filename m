Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265489AbTFVDkW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 23:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265493AbTFVDkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 23:40:22 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:49280 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S265489AbTFVDkT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 23:40:19 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sat, 21 Jun 2003 20:52:43 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Thomas Winischhofer <twini@xfree86.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] SiS IRQ router 96x detection (2.5.69) ...
In-Reply-To: <3EF50D43.6020809@xfree86.org>
Message-ID: <Pine.LNX.4.55.0306212007430.3725@bigblue.dev.mcafeelabs.com>
References: <Pine.LNX.4.55.0306022338530.3631@bigblue.dev.mcafeelabs.com> 
 <3EF248F9.7040402@winischhofer.net> <1056198220.25975.23.camel@dhcp22.swansea.linux.org.uk>
 <Pine.LNX.4.55.0306211314400.3725@bigblue.dev.mcafeelabs.com>
 <3EF50D43.6020809@xfree86.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Jun 2003, Thomas Winischhofer wrote:

> Davide Libenzi wrote:
> > I have to admit that I was tempted to let this go through by simply
> > ignoring you.
>
> Ouch, this hurts. The lawyer in me just told me that this is no proper
> way to argue. And he means both sides. I think he's right.
>
> Davide, calm down and take a deep breath. Better? :)

I am calm :) I do respect Alan but sometime he just says unbeliveable
things.


> Alan probably receives thousands of mails every day and he therefore
> tends to make it somewhat very short sometimes. Be happy that he even
> aswered at all, right?

Not really. Like you were pointing out, this was not :

Subject: [patch] Improving VM performance by 1.02% using bozo-hashes ...

The new SiS chipset using the 96x SB will make the kernel to puke in the
face of the poor user that will try to install Linux on the machine that
is employing it. The whole USB subsystem will remain quite because of this.
Now, the "was so ugly to have no words" was basically because I added
explicit initialization to NULL of the new "detect" function pointer. This
was the note that Alan posted to lkml. I *very personally* do want full
structure initialization when using the old field-order-based method. It
is sure easier for me to add a single "detect" explicit initialization at
the end of the sequence, but it'll become generally a mess if the
structure will grow in number of fields. Think about the old INIT_TASK
macro. I also proposed to rewrite the damn structure array initialization
using the C99 syntax, that way better suite the sparse field
initialization. No answer though. Now, it's not the playing with the PCI
IRQ routing does excite me a lot and I did it simply because my machine
didn't work. I did spend a few hours on the patch and I was willing to
spend another one to see the kernel fixed. But if he does not care, why
should I ?



- Davide

