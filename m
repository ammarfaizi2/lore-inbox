Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285338AbSBCBFJ>; Sat, 2 Feb 2002 20:05:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284732AbSBCBE6>; Sat, 2 Feb 2002 20:04:58 -0500
Received: from mx2.fuse.net ([216.68.1.120]:36268 "EHLO mta02.fuse.net")
	by vger.kernel.org with ESMTP id <S286179AbSBCBEr>;
	Sat, 2 Feb 2002 20:04:47 -0500
Message-ID: <3C5C8CA2.9000103@fuse.net>
Date: Sat, 02 Feb 2002 20:04:34 -0500
From: Nathan <wfilardo@fuse.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20020121
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Issues with 2.5.3-dj1
In-Reply-To: <3C5B5EC0.40503@fuse.net> <20020202055115.GA11359@kroah.com> <3C5B8C0D.8090009@fuse.net> <20020202133358.A5738@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

>On Sat, Feb 02, 2002 at 01:49:49AM -0500, Nathan wrote:
>
> > Alright... a 2.5.3 with no extras boots fine (with init=/bin/bash) and 
> > can load and unload hotplug several times without OOPSing.  So it 
> > appears to be something else.  Hope that helps.
>
> Do you have driverfs mounted ? Can you try 2.5.3 + greg's
> USB driverfs patch ?
>
Unless driverfs is mounted by default or by something other than 
/etc/fstab, no I don't have it on.

w/ Greg's USB driverfs patch : system proves to be stable.
    (though 2.5.3 sometimes looses my keyboard after a time?)

Raw -dj1:  explosion as above. [no ACPI (doesn't compile anyway), no 
preempt this time around, either.]
    (also lost my keyboard.  Odd.  Seems to be about 50% of the time 
with 2.5.3 + anything.)

--Nathan


