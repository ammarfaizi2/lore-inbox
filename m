Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261375AbTA1Vma>; Tue, 28 Jan 2003 16:42:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261370AbTA1Vma>; Tue, 28 Jan 2003 16:42:30 -0500
Received: from jive.SoftHome.net ([66.54.152.27]:14024 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id <S261375AbTA1Vm3> convert rfc822-to-8bit;
	Tue, 28 Jan 2003 16:42:29 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Balram Adlakha <b_adlakha@softhome.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Bootscreen
Date: Wed, 29 Jan 2003 03:18:20 +0530
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200301290318.20817.b_adlakha@softhome.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

though i have recently subscribed to this list (OMG, 30 mails/hour!), I've 
read the whole thread about this bootscreen thing... I see absolutely _no_ 
reason why it should not be included in the kernel configuration, since there 
are patches available already to make it work, and there are already soo many 
useless options that adding another won't make a difference...
Many people will choose to stay away from it, including me, but those users 
coming from the windows world are scared out of their wits when they see the 
kernel booting, and I've seen it myself...
I don't think adding the option to the kernel configuration would do any 
harm...exept that the kernel source may get enlarged by (200 kb?), and the 
kernel source gets enlarged every day anyway... 2.5 is HUGE compared to 
2.2...

On Wednesday 29 January 2003 01:41, Arador wrote:

> yeah, why to do it inside the kernel?
>
> Just run a userspace logo for the first thing in the
> system in the init screens. I don't see a real reason why
> that thing should be put in kernel. Where would you put the
> 800x600 image (since you have nothing mounted)?
>
>
> Just run the first task with something that puts
> a fb logo; and send nothing to the screen until you run
> xdm. That would be nice for the users that doesn't
> want to see those horrible "debug" things.
>
> If i remember correctly, xp doesn't shows the logo
> since the start neither. It does a bit of job before.
>
> A linux kernel doesn't take too much time to boot
> (the ide detection is the slower part i remember)
>
> And the kernel messages always were, always will be,
> useful. To get a clean screen perhaps we could have
> something like a boot parm called silentdmesg, and then
> do the previous thing.

does a slient screen work when you have framebuffer enabled?
