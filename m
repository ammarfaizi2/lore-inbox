Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261269AbUK0RZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261269AbUK0RZo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 12:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261278AbUK0RXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 12:23:49 -0500
Received: from gprs214-89.eurotel.cz ([160.218.214.89]:57729 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261279AbUK0RWZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 12:22:25 -0500
Date: Sat, 27 Nov 2004 18:22:05 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Jan Rychter <jan@rychter.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Suspend 2 merge: 35/51: Code always built in to the kernel.
Message-ID: <20041127172205.GB1330@elf.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101298112.5805.330.camel@desktop.cunninghams> <20041125233243.GB2909@elf.ucw.cz> <1101427035.27250.161.camel@desktop.cunninghams> <m2fz2vfyyc.fsf@tnuctip.rychter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2fz2vfyyc.fsf@tnuctip.rychter.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On So 27-11-04 01:00:59, Jan Rychter wrote:
> >>>>> "Nigel" == Nigel Cunningham <ncunningham@linuxmail.org>:
>  Nigel> Hi.
>  Nigel> On Fri, 2004-11-26 at 10:32, Pavel Machek wrote:
> [...]
>  >> Plus kernel now actually expects user interaction to solve problems
>  >> during boot. No, no.
> 
>  Nigel> You want your cake and to eat it too? :> We don't want to warn
>  Nigel> the user before they shoot themselves in the foot, but not
>  Nigel> loudly enough that they can't help notice and choose to do
>  Nigel> something before the damage is done?
> 
> You're forgetting that Pavel's idea of user interaction is via BUG_ON()
> and panic(). That's obviously "cleaner", "less ugly", and "smaller".

If you have a "can't happen" condition, it is just plain wrong to
return 0 and succeed. If you can't understand that, well, that's your
problem, not mine.

Now, if you want kernel that asks user "really mount ext3 on /dev/hda3
filesystem to /, WARNING: you should run fsck first, press f to do
that", that's your option, feel free to start your own kernel fork.

								Pavel 
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
