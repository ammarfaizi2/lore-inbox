Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261456AbTA1JBc>; Tue, 28 Jan 2003 04:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261523AbTA1JBc>; Tue, 28 Jan 2003 04:01:32 -0500
Received: from mail2.webart.de ([195.30.14.11]:30990 "EHLO mail2.webart.de")
	by vger.kernel.org with ESMTP id <S261456AbTA1JBa>;
	Tue, 28 Jan 2003 04:01:30 -0500
Message-ID: <398E93A81CC5D311901600A0C9F2928946936D@cubuss2>
From: Raphael Schmid <Raphael_Schmid@CUBUS.COM>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Bootscreen
Date: Tue, 28 Jan 2003 10:01:37 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello World,

this eMail shall be a means of bringing up again a topic I believe has
already been discussed extensively. Wait! Don't delete, read further
please!

[ Note: please cc: me in any replies as <raphael@arrivingarrow.net>,
  since (a) I'm at work and (b) not subscribed to the list. Thanks. ]

It is my very understanding one can not have, conveniently it should be,
a simple *bootscreen* under Linux. With that I mean a picture of at
least 256 (indexed) colours at a size of 640x480 pixels. Doesn't have
to be a higher resolution. And yes, I'm taking the standpoint that every
computer nowadays [where this shall be possible] *can* do that resolution.

Framebuffer, I hear people shouting? Well. During the last *two days*,
which includes one full night, I've been trying to get my v2.4.20 kernel
to display such a bootscreen. All I get is segfaults. I've tried what I
believe to be every tool out there: pnmtologo, fblogo, boot_logo, the
GIMP plugin. You name them. None of which wouldn't have required any
hacking to work with 2.4.20, by the way...

And maybe it's right, maybe I demand too much from the (VESA) framebuffer.
Maybe my picture is also too complex, but I've tried simple ones as well.
And anyway: I don't *want* any simple picture, I want as complex a picture
as it gets. In 640x480. At 256 indexed colours.

So although I'm just learning C and can't code it myself, here's an idea:

If Syslinux can display this kind of images, and if LILO can, so why would
Linux be unable to display it? VESA was the term, if I right remember?
If this request is too much of an effort to implement, then couldn't there
be a kernel configuation option that simply tells Linux to leave the screen
as it is, until some user space software (X) changes it? (In conjunction
with console=/dev/null or something). I just want my picture remain there.

I realize these ideas may sound kind of alien to you, but they make sense.
Windows, MacOS all have bootscreens. There really is no way why Linux
shouldn't.

In that veine, another thing I've been puzzled with... can you somehow
disable
virtual consoles (Alt-Fx) completely while still maintaining an interface
for
X to come up on?

Thanks for reading through until here. Thanks for any considerations in
advance.

Your truly, Raphael
