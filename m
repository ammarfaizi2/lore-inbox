Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275818AbRJNRbb>; Sun, 14 Oct 2001 13:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275823AbRJNRbM>; Sun, 14 Oct 2001 13:31:12 -0400
Received: from a213-84-34-179.xs4all.nl ([213.84.34.179]:6380 "HELO
	mail.binary-magic.com") by vger.kernel.org with SMTP
	id <S275818AbRJNRbA>; Sun, 14 Oct 2001 13:31:00 -0400
Content-Type: text/plain; charset=US-ASCII
From: Take Vos <Take.Vos@binary-magic.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.12, Dell i8100 hangs when unpluggin power
Date: Sun, 14 Oct 2001 19:29:41 +0200
X-Mailer: KMail [version 1.3]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011014173130.AD7BA58@mail.binary-magic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

I've been running 2.4.10 and 2.4.12 on my new Dell inspiron 8100, both of 
which seems to hang as soon as I unplug the power coord, or close the lid.

This problem is even without running X11 at all. Or when removing Power 
Managment from the kernel and/or disabeling it in the bios.

I found a previous message on the kernel mailing list which seems to be
the same bug, I will include it here (I personaly haven't tried 2.4.5 yet):

Georg Nikodym wrote:
> I've been running 2.4.5 on my new Dell I8000 without too many
> problems.  Last night I built -ac13 (on my porch) and booted it
> without incident.  Later, going inside and re-connecting the AC I
> notice that the thing's hung.  I play around a bit and discover that
> the act of plugging or unplugging the power cord will hang the box.
>
> This lead me to disable all power manglement in the BIOS.  No joy.
>
> This problem does not exist using straight 2.4.5.
>
> Has anybody else seen this?  Any debugging suggestions?  Or stated
> differently, has anybody with this machine arrived at a configuration
> that avoids weirdness in the power management framework?
