Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261686AbSLZOMw>; Thu, 26 Dec 2002 09:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261724AbSLZOMw>; Thu, 26 Dec 2002 09:12:52 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:58125 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S261686AbSLZOMv>; Thu, 26 Dec 2002 09:12:51 -0500
Date: Thu, 26 Dec 2002 15:20:32 +0100
From: Jurriaan <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: also frustrated with the framebuffer and your matrox-card in 2.5.53? hack/patch available!
Message-ID: <20021226142032.GA7852@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch to downgrade the framebuffer files in linux-2.5.53 back
to 2.5.50, where the matrox-framebuffer worked perfectly.

It's rather annoying that in a feature-freeze period a change goes in
that cripples the one framebuffer with the best speed and features -
the matrox framebuffer. The author mentioned it could be weeks or months
before he would be able to get his matrox framebuffer working with the
new framework, since its simple API doesn't fit the possibilities of the
matrox framebuffer. Read more about it on the fbdev-users or
fbdev-developers mailinglist on sourceforge.

He advised people to stay at 2.5.50, or copy some files from
drivers/video etc. from 2.5.50 into 2.5.53.

That's what I did, some small changes were also necessary.

This patch has _no_ support. Don't tell me devfs stopped working, don't
tell me multiple-head output doesn't work, don't ask me to update it to
a newer kernel-version.

All I know is:

- it works here, on a smp X86 system with a G400 & preempt on.
- switching to XFree and back works.
- switching consoles works.

That's enough for me.

The patch is at

http://www.xs4all.nl/~thunder7/matroxfb_2553.diff.bz2

Good luck,
Jurriaan
-- 
When asked by an anthropologist what the Indians called America
before the white men came, an Indian said simply "Ours."
	Vine Deloria, Jr.
GNU/Linux 2.5.50 SMP/ReiserFS 2x2752 bogomips load av: 1.85 2.21 1.38
