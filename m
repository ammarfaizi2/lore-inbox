Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290919AbSBVBXu>; Thu, 21 Feb 2002 20:23:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290878AbSBVBXm>; Thu, 21 Feb 2002 20:23:42 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:22028 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S290827AbSBVBXd>; Thu, 21 Feb 2002 20:23:33 -0500
Date: Fri, 22 Feb 2002 02:23:29 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dave Jones <davej@suse.de>, Benjamin Pharr <ben@benpharr.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.5-dj1 - Bug Reports
Message-ID: <20020222022329.A3533@suse.cz>
In-Reply-To: <20020221233700.GA512@hst000004380um.kincannon.olemiss.edu> <20020222022149.N5583@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020222022149.N5583@suse.de>; from davej@suse.de on Fri, Feb 22, 2002 at 02:21:49AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2002 at 02:21:49AM +0100, Dave Jones wrote:
>  > It compiled fine. When I booted up everything looked normal with the
>  > exception of a 
>  > eth1: going OOM 
>  > message that kept scrolling down the screen. My eth1 is a natsemi card.
> 
>  That's interesting. Probably moreso for Manfred. I'll double check
>  I didn't goof merging the oom-handling patch tomorrow.
> 
>  > Eventually that stopped and gdm came up. For some reason my keyboard and
>  > mouse wouldn't work.
> 
>  -dj includes a different input layer to Linus' tree, which requires
>  some extra options enabled.  Vojtech, this is quite a frequent
>  'bug report', and I think if you merged that with Linus, the number
>  of reports would climb. Is there a possibility of simplifying the
>  config.in somewhat? Or at least changing the defaults to give the
>  element of least surprise..

The defaults are changed :(. However people coying their .configs over
don't use the defaults. The help files say what to do in case of doubt.
I'm not sure what more I can do.

I'll try to think about that.

>  > It got to check.c in fs/partitions before stopping with an error.
> 
>  That one I've not got an answer for. Can you give me more information
>  about your disk layout, partitions, number of disks, scsi?/ide?/lvm?
>  
> -- 
> | Dave Jones.        http://www.codemonkey.org.uk
> | SuSE Labs

-- 
Vojtech Pavlik
SuSE Labs
