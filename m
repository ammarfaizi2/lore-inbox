Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267630AbTA1SMt>; Tue, 28 Jan 2003 13:12:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267648AbTA1SMt>; Tue, 28 Jan 2003 13:12:49 -0500
Received: from [196.12.44.6] ([196.12.44.6]:18918 "EHLO students.iiit.net")
	by vger.kernel.org with ESMTP id <S267630AbTA1SMr>;
	Tue, 28 Jan 2003 13:12:47 -0500
Date: Tue, 28 Jan 2003 23:51:21 +0530 (IST)
From: Prasad <prasad_s@students.iiit.net>
To: Raphael Schmid <Raphael_Schmid@CUBUS.COM>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Bootscreen
In-Reply-To: <398E93A81CC5D311901600A0C9F2928946936D@cubuss2>
Message-ID: <Pine.LNX.4.44.0301282348340.25372-100000@students.iiit.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The linux progress patch could be what you want.  I tried porting this to 
2.4.18 and was successful in just a couple of hours.  I have tested the 
thing on many systems.  It worked well.  If any one is interested maybe i 
can mail you the patch for 2.4.18-4.

Prasad.

On Tue, 28 Jan 2003, Raphael Schmid wrote:

> Hello World,
> 
> this eMail shall be a means of bringing up again a topic I believe has
> already been discussed extensively. Wait! Don't delete, read further
> please!
> 
> [ Note: please cc: me in any replies as <raphael@arrivingarrow.net>,
>   since (a) I'm at work and (b) not subscribed to the list. Thanks. ]
> 
> It is my very understanding one can not have, conveniently it should be,
> a simple *bootscreen* under Linux. With that I mean a picture of at
> least 256 (indexed) colours at a size of 640x480 pixels. Doesn't have
> to be a higher resolution. And yes, I'm taking the standpoint that every
> computer nowadays [where this shall be possible] *can* do that resolution.
> 
> Framebuffer, I hear people shouting? Well. During the last *two days*,
> which includes one full night, I've been trying to get my v2.4.20 kernel
> to display such a bootscreen. All I get is segfaults. I've tried what I
> believe to be every tool out there: pnmtologo, fblogo, boot_logo, the
> GIMP plugin. You name them. None of which wouldn't have required any
> hacking to work with 2.4.20, by the way...
> 
> And maybe it's right, maybe I demand too much from the (VESA) framebuffer.
> Maybe my picture is also too complex, but I've tried simple ones as well.
> And anyway: I don't *want* any simple picture, I want as complex a picture
> as it gets. In 640x480. At 256 indexed colours.
> 
> So although I'm just learning C and can't code it myself, here's an idea:
> 
> If Syslinux can display this kind of images, and if LILO can, so why would
> Linux be unable to display it? VESA was the term, if I right remember?
> If this request is too much of an effort to implement, then couldn't there
> be a kernel configuation option that simply tells Linux to leave the screen
> as it is, until some user space software (X) changes it? (In conjunction
> with console=/dev/null or something). I just want my picture remain there.
> 
> I realize these ideas may sound kind of alien to you, but they make sense.
> Windows, MacOS all have bootscreens. There really is no way why Linux
> shouldn't.
> 
> In that veine, another thing I've been puzzled with... can you somehow
> disable
> virtual consoles (Alt-Fx) completely while still maintaining an interface
> for
> X to come up on?
> 
> Thanks for reading through until here. Thanks for any considerations in
> advance.
> 
> Your truly, Raphael
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Failure is not an option

