Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161476AbWHDV7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161476AbWHDV7E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 17:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161512AbWHDV7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 17:59:04 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:4573 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161476AbWHDV7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 17:59:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=dfbDkMgwxJPRRnJHLoW7PhM9AYrcKq/VzK70v0veosD6JfACrVgWM+FGBg+5jmRMroLvi9AvLatTHkvgJx3aJU0G12PF3o/FJJKtXR0RgND+UOt0TwXfS/op0Xg3ZxowxFIFafKSHC66m2mV++aBQjgydYpyPYSLFg6pNicG8cg=
Date: Fri, 4 Aug 2006 17:59:58 -0400
To: Brannon Barrett Klopfer <bklopfer@stanford.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Completely dead on resume (no caps lock, nada)
Message-ID: <20060804215957.GA7008@nineveh.rivenstone.net>
Mail-Followup-To: Brannon Barrett Klopfer <bklopfer@stanford.edu>,
	linux-kernel@vger.kernel.org
References: <1154721378.44d3a6627e951@webmail.stanford.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154721378.44d3a6627e951@webmail.stanford.edu>
User-Agent: Mutt/1.5.11
From: jfannin@gmail.com (Joseph Fannin)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2006 at 12:56:18PM -0700, Brannon Barrett Klopfer wrote:
> Hello,
>
> Sorry to bug the entire list with such a vaugue post, but I'm not sure what
> driver/subsystem is causing this problem. I'm sure you all are sick of "My
> computer won't suspend, what do I do?" posts, but...well, my computer won't
> suspend...

    If no one reports bugs, they don't get fixed.

    Pavel Machek <pavel@suse.cz> is the swsusp maintainer, and should
have been CC'd on this, otherwise he'll probably never see it.
Linux-kernel is a busy place. :-)

    I know Mr. Machek wants swsusp bug reports filed in Bugzilla at
http://bugzilla.kernel.org , so you should do that, and then send a
follow up to this, CC'd to Pavel, with a bugzilla bug number.

CC'ing Rafael J. Wysocki <rjw@sisk.pl> as well probably wouldn't hurt.

>
> It's a brand-new HP dv8000t laptop (Phoenix BIOS, latest version, core duo,
> ahci/ata_piix [native/legacy]). Suspending (echo mem > /sys/power/state)
> works fine, but upon resuming, absolutly nothing works -- backlight stays
> off, caps/numlock, network, etc. all dead. I've also tried
>
> # cat `which poweroff` > /dev/null # cache it, in case disk dies upon resume
> # echo mem > /sys/power/state ; poweroff -f
>
> but it still just hangs (i.e., seems the entire system is just...dead). I've
> tried numerous patches from here and there, and tried both native (ahci) and
> legacy (ata_piix) sata, and a kernel with as little support as possible --
> no usb, ide, smp, module, preempt, etc. I won't flood the lists with other
> info, but it's all at
>
> http://www.stanford.edu/~bklopfer/wontsuspend/
>
> I'd be more than happy to try patches/let someone ssh into my box if it'd
> help (new, so nothing sensitive on it yet).
>
> Thanks,
> Brannon Klopfer

Thank you.

--
Joseph Fannin
jfannin@gmail.com

