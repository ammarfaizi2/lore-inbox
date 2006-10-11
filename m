Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161269AbWJKXGm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161269AbWJKXGm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 19:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161271AbWJKXGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 19:06:42 -0400
Received: from mail.kroah.org ([69.55.234.183]:12750 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161269AbWJKXGl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 19:06:41 -0400
Date: Wed, 11 Oct 2006 15:59:11 -0700
From: Greg KH <greg@kroah.com>
To: Dave Jones <davej@redhat.com>, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk
Subject: Re: [stable] [patch 00/67] 2.6.18-stable review
Message-ID: <20061011225911.GA26135@kroah.com>
References: <20061011210310.GA16627@kroah.com> <20061011213648.GC32371@redhat.com> <20061011215943.GA19559@suse.de> <20061011221924.GB2248@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061011221924.GB2248@redhat.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2006 at 06:19:24PM -0400, Dave Jones wrote:
> On Wed, Oct 11, 2006 at 02:59:43PM -0700, Greg KH wrote:
>  
>  > > Is it intentional that this adds a include/linux/utsrelease.h ?
>  > > I don't see any patch that adds it in the review mails, but its there in the gz.
>  > 
>  > Hm, I guess the dontdiff file wasn't updated, as I built and booted out
>  > of that directory, so that is where it came from.  Sorry about that.
>  > 
>  > Anyone want to update dontdiff?  :)
> 
> Ah, was looking at wrong tree. It's not in -stable..
> 
> Signed-off-by: Dave Jones <davej@redhat.com>
> 
> --- 1/Documentation/dontdiff	2006-09-19 23:42:06.000000000 -0400
> +++ 2/Documentation/dontdiff	2006-10-11 14:21:40.000000000 -0400
> @@ -135,6 +135,7 @@
>  times.h*
>  tkparse
>  trix_boot.h
> +utsrelease.h*
>  version.h*
>  vmlinux
>  vmlinux-*

Thanks, will queue it up for the next -stable release.

greg k-h
