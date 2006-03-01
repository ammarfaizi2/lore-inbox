Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932731AbWCAAW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932731AbWCAAW5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 19:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932732AbWCAAW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 19:22:57 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:58340
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932731AbWCAAW4 (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Tue, 28 Feb 2006 19:22:56 -0500
Date: Tue, 28 Feb 2006 16:23:02 -0800
From: Greg KH <greg@kroah.com>
To: Nikita Danilov <nikita@clusterfs.com>
Cc: gregkh@suse.de, Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>,
       Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [RFC] Add kernel<->userspace ABI stability documentation
Message-ID: <20060301002302.GF23716@kroah.com>
References: <20060227190150.GA9121@kroah.com> <17412.13937.158404.935427@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17412.13937.158404.935427@gargle.gargle.HOWL>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2006 at 02:39:29PM +0300, Nikita Danilov wrote:
> Greg KH writes:
> 
> [...]
> 
>  > +
>  > +  stable/
>  > +	This directory documents the interfaces that have determined to
>  > +	be stable.  Userspace programs are free to use these interfaces
>  > +	with no restrictions, and backward compatibility for them will
>  > +	be guaranteed for at least 2 years.  Most simple interfaces
>  > +	(like syscalls) are expected to never change and always be
>  > +	available.
> 
> What about separating "stable" ("guaranteed for at least 2 years") and
> "standard" (core unix interface is not going to change ever)?

Why?  Would that mean that the POSIX-like syscalls would only be in
"standard"?  What else would you think would be in that category?

thanks,

greg k-h
