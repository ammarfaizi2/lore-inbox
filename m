Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262133AbUK0F27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262133AbUK0F27 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 00:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbUK0Dyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 22:54:44 -0500
Received: from zeus.kernel.org ([204.152.189.113]:5572 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262518AbUKZTdb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:33:31 -0500
Date: Fri, 26 Nov 2004 01:23:14 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend 2 merge: 35/51: Code always built in to the kernel.
Message-ID: <20041126002314.GP2711@elf.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101298112.5805.330.camel@desktop.cunninghams> <20041125233243.GB2909@elf.ucw.cz> <1101427035.27250.161.camel@desktop.cunninghams> <20041126000853.GL2711@elf.ucw.cz> <1101428250.27250.188.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101428250.27250.188.camel@desktop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Kernel boot is not expected to be interactive. I'd do
> > 
> > if (can_erase_image)
> > 	printk("Incorrect kernel version, image killed\n");
> > else
> > 	panic("Can't kill suspended image");
> > 
> 
> Comes down, again, to user friendliness. Just because I can erase the
> image, doesn't mean I should. It may be that the user just pressed the
> down arrow one too few times in lilo, and they really do have the right
> kernel, but started the wrong one. Or it may be that they're still
> setting up their initrd, didn't get it quite right, know that no damage
> will be done and want to continue booting. We should let the user think
> about what they want to do and then do it.

User friendlyness is nice, but I think "boot is not interactive" is
stronger requirement than that.

> I need to get on with the work I planned on doing today, so I'm going to
> hang up after sending this. That's not at all to say that I want you to
> stop sending email; just that I won't be replying for a while.

No problem, I need some sleep.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
