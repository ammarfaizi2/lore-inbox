Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135842AbRDTRMw>; Fri, 20 Apr 2001 13:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135914AbRDTRMg>; Fri, 20 Apr 2001 13:12:36 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:6661 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S135842AbRDTRMT>;
	Fri, 20 Apr 2001 13:12:19 -0400
Message-ID: <20010420190227.B905@bug.ucw.cz>
Date: Fri, 20 Apr 2001 19:02:27 +0200
From: Pavel Machek <pavel@suse.cz>
To: John Fremlin <chief@bandits.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: sfr@linuxcare.com.au, linux-kernel@vger.kernel.org,
        apenwarr@worldvisions.ca
Subject: Re: Let init know user wants to shutdown
In-Reply-To: <E14pqYS-0004Y3-00@the-village.bc.nu> <m27l0i58i3.fsf@boreas.yi.org.>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <m27l0i58i3.fsf@boreas.yi.org.>; from John Fremlin on Wed, Apr 18, 2001 at 08:10:44PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > I'm wondering if that veto business is really needed. Why not reject
> > > *all* APM rejectable events, and then let the userspace event handler
> > > send the system to sleep or turn it off? Anybody au fait with the APM
> > > spec?
> > 
> > Because apmd is optional
> 
> The veto stuff only comes into action, iff someone has registered as
> willing to exercise this power. We would not break compatibility with
> any std kernel by instead having a apmd send a "reject all" ioctl
> instead, and so deal with events without having the pressure of having
> to reject or accept them, and let us remove all the veto code from the
> kernel driver. Or am I missing something?

No, this looks reasonable.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
