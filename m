Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965011AbWEJQRg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965011AbWEJQRg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 12:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965012AbWEJQRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 12:17:36 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:32507 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S965011AbWEJQRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 12:17:35 -0400
Date: Wed, 10 May 2006 12:17:30 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Mark Hounschell <markh@compro.net>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: rt20 patch question
In-Reply-To: <446207D6.2030602@compro.net>
Message-ID: <Pine.LNX.4.58.0605101215220.19935@gandalf.stny.rr.com>
References: <446089CF.3050809@compro.net> <1147185483.21536.13.camel@c-67-180-134-207.hsd1.ca.comcast.net>
 <4460ADF8.4040301@compro.net> <Pine.LNX.4.58.0605100827500.3282@gandalf.stny.rr.com>
 <4461E53B.7050905@compro.net> <Pine.LNX.4.58.0605100938100.4503@gandalf.stny.rr.com>
 <446207D6.2030602@compro.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Wow! I asked for some info on your system, and boy, did I get info! :)

On Wed, 10 May 2006, Mark Hounschell wrote:

>
> Ok, I'll try to explain the application. It is an emulation of some old
> legacy hardware (SEL-32) that ran a proprietary RTOS (MPX-32). We
> emulate the hardware not the software. We have some specialized pci
> cards that emulate some of that hardware. IE, a card that has some
> timers and external interrupt capabilities (RTOM). All our drivers are
> GPL BTW.
>

[snip long explaination of system]

>
> So to my problem. What I mean by "the machine stops" is just that all
> indications of the mouse, keyboard, and vidio stop. Then in a few
> seconds will usually continue. At first I only saw problems when using
> ethernet in the emulation. I would telnet into the emulation from the
> linux box and do the equivalent of cat'ing a very large file. The
> machine will always "stop" somewhere randomly along the display. Then
> maybe continue on or maybe not. So I thought I might have a problem with
> my ethernet module. Then I noticed similar things with the SCSI module
> when accessing legacy scsi devices from within the emulation. Somtimes
> the whole machine doesn't stop. It would appear that only somethings
> have stopped. Like one or more of my I/O threads??
>
> I can only say for sure that I do not have these "stops" when running
> any other kernel or when running the rt20 kernel in any of the
> non-complete preemption modes.
>
> The only change that had to be made to this app for it to run at all on
> the rt20 kernel was insuring that the RTOM irq thread was at a higher
> priority than the CPU process/thread. Otherwise no signals were received
> from the RTOM.
>

Well, I need to leave the office tonight.  I'll look at it in my hotel,
and tomorrow, I'll give some feedback.

Thanks,

-- Steve

