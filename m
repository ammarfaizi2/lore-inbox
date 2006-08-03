Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030219AbWHCUED@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030219AbWHCUED (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 16:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030221AbWHCUED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 16:04:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:34776 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030219AbWHCUEB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 16:04:01 -0400
Date: Thu, 3 Aug 2006 12:59:22 -0700
From: Greg KH <greg@kroah.com>
To: Dave Jones <davej@redhat.com>, Zachary Amsden <zach@vmware.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Jack Lo <jlo@vmware.com>
Subject: Re: A proposal - binary
Message-ID: <20060803195922.GA28537@kroah.com>
References: <44D1CC7D.4010600@vmware.com> <1154603822.2965.18.camel@laptopd505.fenrus.org> <44D23B84.6090605@vmware.com> <20060803190327.GA14237@kroah.com> <44D24B31.2080802@vmware.com> <20060803193600.GA14858@kroah.com> <20060803195617.GD16927@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060803195617.GD16927@redhat.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 03:56:17PM -0400, Dave Jones wrote:
> On Thu, Aug 03, 2006 at 12:36:00PM -0700, Greg Kroah-Hartman wrote:
> 
>  > > That is good to know.  But there is a kernel option which doesn't make 
>  > > much sense in that case:
>  > > 
>  > > [*] Select only drivers that don't need compile-time external firmware
>  > 
>  > No, that is very different.  That option is present if you don't want to
>  > build some firmware images from the source that is present in the kernel
>  > tree, and instead, use the pre-built stuff that is also present in the
>  > kernel tree.
> 
> You're describing PREVENT_FIRMWARE_BUILD.  The text Zach quoted is from
> STANDALONE, which is something else completely.  That allows us to not
> build drivers that pull in things from /etc and the like during compile.
> (Whoever thought that was a good idea?)

Oops, sorry, you are right.  Yeah, some of those alsa driver look for
files in /etc when building, very strange...

Either way it's not what I think Zach was thinking it was about.

thanks,

greg k-h
