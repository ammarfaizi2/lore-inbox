Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751661AbWEaE1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751661AbWEaE1E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 00:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751671AbWEaE1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 00:27:04 -0400
Received: from smtp.enter.net ([216.193.128.24]:1548 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S1751655AbWEaE1D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 00:27:03 -0400
From: "D. Hazelton" <dhazelton@enter.net>
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: OpenGL-based framebuffer concepts
Date: Wed, 31 May 2006 00:26:00 +0000
User-Agent: KMail/1.8.1
Cc: "Dave Airlie" <airlied@gmail.com>, "Pavel Machek" <pavel@ucw.cz>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org, adaplas@gmail.com
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <200605302314.25957.dhazelton@enter.net> <9e4733910605302116s5a47f5a3kf0f941980ff17e8@mail.gmail.com>
In-Reply-To: <9e4733910605302116s5a47f5a3kf0f941980ff17e8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605310026.01610.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 31 May 2006 04:16, Jon Smirl wrote:
> On 5/30/06, D. Hazelton <dhazelton@enter.net> wrote:
> > Like I've said, this has gone onto my list. Now to get back to the
> > code... I really do want to see about getting this stuff into the kernel
> > ASAP.
>
> You might want to leave the DRM hot potato alone for a while and just
> work on fbdev. Fbdev is smaller and it is easier to get changes
> accepted.

Yes, but I have accepted that there is a certain direction and order the 
maintainers want things done in. For this reason I can't just leave DRM 
alone.

> A small project would be to get secondary adapter reset working. I
> believe the work would be well received by the fbdev people.
>
> You can start by using vbetool with a slight modification to get the
> ROM image from sysfs
> Then add the check in fbcore to see if it is a secondary adapter.
> Modify /sys/class/firmware/ to handle generic helpers instead of just
> the firmware one
> After you get that going make the real reset app with emu86 support, etc
> Finally modify the ROM attribute so that you can write the altered ROM
> image back in
> Keep everything as a separate project until the kernel (klibc merge)
> tree is ready to accept it
>
> This is not a big project but it could take up to a month to complete
> since you need to familiarize yourself with how everything works.

On the list already, almost exactly as you describer it. It's going to wait 
until I have a solid framework layed out.

DRH
