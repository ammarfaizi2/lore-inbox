Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030195AbWHCVqk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030195AbWHCVqk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 17:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030187AbWHCVqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 17:46:40 -0400
Received: from mail.suse.de ([195.135.220.2]:57256 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030183AbWHCVqj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 17:46:39 -0400
Date: Thu, 3 Aug 2006 14:41:47 -0700
From: Greg KH <greg@kroah.com>
To: Dave Jones <davej@redhat.com>, "Brown, Len" <len.brown@intel.com>,
       Adrian Bunk <bunk@stusta.de>, Zachary Amsden <zach@vmware.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Jack Lo <jlo@vmware.com>,
       v4l-dvb-maintainer@linuxtv.org, linux-acpi@vger.kernel.org
Subject: Re: Options depending on STANDALONE
Message-ID: <20060803214147.GA20468@kroah.com>
References: <CFF307C98FEABE47A452B27C06B85BB601260CC7@hdsmsx411.amr.corp.intel.com> <20060803205127.GC10935@kroah.com> <20060803210130.GJ16927@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060803210130.GJ16927@redhat.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 05:01:30PM -0400, Dave Jones wrote:
> On Thu, Aug 03, 2006 at 01:51:27PM -0700, Greg Kroah-Hartman wrote:
>  > On Thu, Aug 03, 2006 at 04:49:08PM -0400, Brown, Len wrote:
>  > > I've advised SuSE many times that they should not be shipping it,
>  > > as it means that their supported OS is running on modified firmware --
>  > > which, by definition, they can not support.  Indeed, one could view
>  > > this method as couter-productive to the evolution of Linux --
>  > > since it is our stated goal to run on the same machines that Windows
>  > > runs on -- without requiring customers to modify those machines
>  > > to run Linux.
>  > 
>  > Ok, if it's your position that we should not support this, I'll see what
>  > I can do to remove it from our kernel tree...
>  > 
>  > If there are any other patches that we are carrying that you (or anyone
>  > else) feel we should not be, please let me know.
> 
> It's somewhat hard to tell when the source rpm's don't match the binaries.
> See ftp://ftp.suse.com/pub/projects/kernel/kotd/x86_64/HEAD for example,
> and notice the lack of 2.6.18rc3 source, just 2.6.16.  Or am I looking
> in the wrong place ? (The other arch's all seem to suffer this curious problem).

Bleah, our KOTD build is still broken...

We do have a 2.6.18rc3 kernel, and everything rebased on that, but it's
not getting out to the world just yet for some odd reason.  It will show
up in the next Opensuse 10.2 Alpha release some time next week, but it
should be mirroring nightly too.

/me goes off to kick the build system

thanks,

greg k-h
