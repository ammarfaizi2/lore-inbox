Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757388AbWLCRAn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757388AbWLCRAn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 12:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757418AbWLCRAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 12:00:43 -0500
Received: from foo.birdnet.se ([213.88.146.6]:20926 "EHLO foo.birdnet.se")
	by vger.kernel.org with ESMTP id S1757388AbWLCRAm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 12:00:42 -0500
Message-ID: <20061203170046.28314.qmail@cdy.org>
Date: Sun, 3 Dec 2006 18:00:46 +0100
From: Peter Stuge <stuge-linuxbios@cdy.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>, linuxbios@linuxbios.org
Subject: Re: [LinuxBIOS] #57: libusb host program for PLX NET20DC debug device
Mail-Followup-To: "Eric W. Biederman" <ebiederm@xmission.com>,
	Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
	Andi Kleen <ak@suse.de>, linuxbios@linuxbios.org
References: <5986589C150B2F49A46483AC44C7BCA4907276@ssvlexmb2.amd.com> <20061201191916.GB3539@suse.de> <20061201204249.28842.qmail@cdy.org> <m164cvgvwz.fsf@ebiederm.dsl.xmission.com> <20061201214631.6991.qmail@cdy.org> <m1wt5bfces.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1wt5bfces.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2006 at 04:02:03PM -0700, Eric W. Biederman wrote:
> >> Sure, I will send it out shortly.  I currently have a working
> >> user space libusb thing (easy, but useful for my debug)
> >
> > Hm - for driving which end?
> 
> Either.  The specific device we are talking about doesn't care.

Which device do you have?


> > The debug port isn't really supposed to be used with anything but
> > a debug device - which can't be enumerated normally anyway.
> 
> It depends.  If you have a debug cable with magic ends and a
> hardcoded address of 127 the normal enumeration doesn't work.  I
> don't think anyone actually makes one of those.

Only one of the ports on Stefan's PLX NET20DC that I had a look at
during the LinuxBIOS symposium enumerated for me.


> Debug devices are also allowed to be normal devices that just
> support the debug descriptor.  Which is what I'm working with.

Aye. I would be happy if we could get something out, as you have
done! :) Looking forward to trying it, I hope I get my device soon.


//Peter
