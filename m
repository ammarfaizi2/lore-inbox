Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129331AbRBGMaw>; Wed, 7 Feb 2001 07:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129282AbRBGMab>; Wed, 7 Feb 2001 07:30:31 -0500
Received: from monza.monza.org ([209.102.105.34]:11531 "EHLO monza.monza.org")
	by vger.kernel.org with ESMTP id <S129078AbRBGMaT>;
	Wed, 7 Feb 2001 07:30:19 -0500
Date: Wed, 7 Feb 2001 04:30:13 -0800
From: Tim Wright <timw@splhi.com>
To: Pavel Machek <pavel@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Enabling ACPI and APM at same time?
Message-ID: <20010207043013.A15326@kochanski.internal.splhi.com>
Reply-To: timw@splhi.com
Mail-Followup-To: Pavel Machek <pavel@suse.cz>,
	kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20010207115738.A218@bug.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010207115738.A218@bug.ucw.cz>; from pavel@suse.cz on Wed, Feb 07, 2001 at 11:57:38AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From /usr/src/linux-2.4.X/Documentation/pm.txt:
"No sorry, you can not have both ACPI and APM enabled and running at
once.  Some people with broken ACPI or broken APM implementations
would like to use both to get a full set of working features, but you
simply can not mix and match the two.  Only one power management
interface can be in control of the machine at once.  Think about it.."

Sorry :-(

Tim

On Wed, Feb 07, 2001 at 11:57:38AM +0100, Pavel Machek wrote:
> Hi!
> 
> Is it possible to have _both_ ACPI and APM enabled?
> 
> I really need APM on my notebook (so that machine suspends when it
> runs out of batteries, not powers off), but having /proc/power/*
> information would be *very* handy.
> 								Pavel
> -- 
> I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
> Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-- 
Tim Wright - timw@splhi.com or timw@aracnet.com or twright@us.ibm.com
IBM Linux Technology Center, Beaverton, Oregon
Interested in Linux scalability ? Look at http://lse.sourceforge.net/
"Nobody ever said I was charming, they said "Rimmer, you're a git!"" RD VI
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
