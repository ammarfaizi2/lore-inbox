Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265280AbRF0Gkm>; Wed, 27 Jun 2001 02:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265279AbRF0Gkd>; Wed, 27 Jun 2001 02:40:33 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:30730 "EHLO
	mailout03.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S265280AbRF0GkS>; Wed, 27 Jun 2001 02:40:18 -0400
Date: 27 Jun 2001 08:31:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <83fdx3Dmw-B@khms.westfalen.de>
In-Reply-To: <3B395FE5.1070208@zytor.com>
Subject: Re: [PATCH] User chroot
X-Mailer: CrossPoint v3.12d.kh7 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <200106270332.f5R3WxU277042@saturn.cs.uml.edu> <3B395FE5.1070208@zytor.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hpa@zytor.com (H. Peter Anvin)  wrote on 26.06.01 in <3B395FE5.1070208@zytor.com>:

> Albert D. Cahalan wrote:
>
> >
> > Normal users can use an environment provided for them.
> >
> > While trying to figure out why the "heyu" program would not
> > work on a Red Hat box, I did just this. As root I set up all
> > the device files needed, along Debian libraries and the heyu
> > executable itself. It was annoying that I couldn't try out
> > my chroot environment as a regular user.
> >
> > Creating the device files isn't a big deal. It wouldn't be
> > hard to write a setuid app to make the few needed devices.
> > If we had per-user limits, "mount --bind /dev/zero /foo/zero"
> > could be allowed. One way or another, devices can be provided.
> >
>
>
> Hell no!  This would give the user a way to subvert root or other
> system-provided things by having device nodes or such appear where they
> aren't expected.  NOT GOOD.

Well, only allow them where you expect them then. That's easy enough.


MfG Kai
