Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261832AbSIXXDT>; Tue, 24 Sep 2002 19:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261836AbSIXXDT>; Tue, 24 Sep 2002 19:03:19 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:54022 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261832AbSIXXDS>;
	Tue, 24 Sep 2002 19:03:18 -0400
Date: Tue, 24 Sep 2002 16:07:25 -0700
From: Greg KH <greg@kroah.com>
To: "Rhoads, Rob" <rob.rhoads@intel.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Linux Hardened Device Drivers Project
Message-ID: <20020924230724.GB27041@kroah.com>
References: <D9223EB959A5D511A98F00508B68C20C0A5389D8@orsmsx108.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D9223EB959A5D511A98F00508B68C20C0A5389D8@orsmsx108.jf.intel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2002 at 02:46:35PM -0700, Rhoads, Rob wrote:
> 
> First throw away any idea of a spec. That was a bad idea. :)
> 
> Next, turn the first section, "Stability & Reliability" of our 
> original doc into a "Driver Hardening HOWTO". It would be a 
> list of characteristics that all good drivers should have, 
> packed with examples to back it up. 

Sounds very good.  I recommend that it be written in DocBook and added
to the Documentation/DocBook directory of the kernel tree.

> BTW, by no means did I or anyone involved on this project, ever 
> mean to imply that the current drivers in the kernel are "bad". 
> Rather, I'd like to capture a list of the best practices and 
> document them. In any event our current list needs to be 
> strengthened with concrete examples. My thinking is that we 
> should work with the Kernel Janitor project. This is where 
> Intel can probably really help out.

Great, the janitor project can really use extra people to help out.  I
suggest that you read over their TODO list again and pick up the pieces
from there that are missing from your "Driver Hardening HOWTO".

> The section on Instrumentation should be broken up and each piece 
> dealt with separately as separate project. Most likely killed outright 
> or as part of existing efforts. I see this section as not having
> anything to do with driver hardening and more to do with driver RAS.

Agreed.

> POSIX Event Logging-- is a dead issue. The mailing list feedback 
> is making that point very clear, many thanks. The current
> thread on an alternative, seems like there is some sort of need
> for event logging. Whatever the final decision that the Linux 
> community decides, we'll do.

Thanks for listening.

> There seems to be a desire to have some sort of driver diagnostics.
> We can work on that with the existing linux-diag project.

Sounds good.  I know those people are actively working to get their code
into the 2.5 kernel, using the driver model.  This is a good thing.

> Statistics needs to be debated on its own merits. There are some 
> arguments for keeping it, but I think that stats could be better 
> handled in user-space and NOT kernel space. IMHO it's not driver 
> hardening, therefore it's a separate project. 

Agreed, it should be done in userspace.

> Third, the most of the section on High Availability should just 
> be axed. The big exception being "fault injection testing". 
> 
> I see value in keeping FI testing. I think that getting FI 
> tools into the hands of developers would be worthwhile. Why? 
> Because letting people do more complicated testing, produces 
> better code. I think there is room for us to work on a set of 
> FI tools.

It would be wonderful if there were some good FI tools that were
available for our use.  It can only help to make better drivers.

Thank you for your response, and for listening to the community.

greg k-h
