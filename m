Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964842AbWCHAaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbWCHAaF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 19:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964841AbWCHAaE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 19:30:04 -0500
Received: from smtp-1.llnl.gov ([128.115.3.81]:5317 "EHLO smtp-1.llnl.gov")
	by vger.kernel.org with ESMTP id S964842AbWCHAaA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 19:30:00 -0500
From: Dave Peterson <dsp@llnl.gov>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] EDAC: core EDAC support code
Date: Tue, 7 Mar 2006 16:29:28 -0800
User-Agent: KMail/1.5.3
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, arjan@infradead.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, alan@redhat.com,
       gregkh@kroah.com
References: <200601190414.k0J4EZCV021775@hera.kernel.org> <200603070903.19226.dsp@llnl.gov> <20060307172054.GA7293@kroah.com>
In-Reply-To: <20060307172054.GA7293@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603071629.28247.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 March 2006 09:20, Greg KH wrote:
> > Ok, I assume the comment refers to the following:
> >
> >     Attributes should be ASCII text files, preferably with only one value
> >     per file. It is noted that it may not be efficient to contain only
> >     value per file, so it is socially acceptable to express an array of
> >     values of the same type.
> >
> > I was initially a bit confused because I thought the comment
> > specifically pertained to the piece of code shown above.  I need to
> > take a closer look at the EDAC sysfs code - I'm not as familiar with
> > some of its details as I should be.  Thanks for pointing out the
> > issue.
>
> How else should we word the above text so that people realize that it
> pertains to them?  You aren't the first person to ignore it, so there is
> a real problem here :(

I think it's written clearly as it is.  I didn't write the
sysfs-specific parts of the EDAC code.  However I'll take the blame
for not having reviewed it more carefully before it went upstream.
I guess my attention has been divided among too many things lately.
