Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129129AbRBFP3a>; Tue, 6 Feb 2001 10:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129172AbRBFP3U>; Tue, 6 Feb 2001 10:29:20 -0500
Received: from hacksaw.org ([216.41.5.170]:21865 "EHLO
	habitrail.home.fools-errant.com") by vger.kernel.org with ESMTP
	id <S129129AbRBFP3J>; Tue, 6 Feb 2001 10:29:09 -0500
Message-Id: <200102061528.f16FSir15100@habitrail.home.fools-errant.com>
X-Mailer: exmh version 2.1.1 10/15/1999
To: rob@sysgo.de
cc: Pavel Machek <pavel@suse.cz>, Patrizio Bruno <patrizio@dada.it>,
        linux-kernel@vger.kernel.org
Subject: Re: Disk is cheap? 
In-Reply-To: Your message of "Tue, 06 Feb 2001 15:49:30 +0100."
             <01020616023400.03941@rob> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 06 Feb 2001 10:28:44 -0500
From: Hacksaw <hacksaw@hacksaw.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sam, 03 Feb 2001 you wrote:
> > Actually, most of that time is spent running bash/sleep 1. Startup
> > scripts tend to be poorly designed.
> 
> Yes!

I'm not so sure. I'm using RedHat 6.2, and it seems the only time a startup script calls sleep is when it gives you a chance to do interactive startup, and when you are looking for an NIS server. You could certainly remove those.

All the other calls to sleep are in the stop sections, where you want to make sure the thing died before proceeding.

But paring down the startup scripts is a good idea. For something like an embedded device, you might even want to go with a custom init, that just runs your main program. 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
