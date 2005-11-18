Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161259AbVKRVtD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161259AbVKRVtD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 16:49:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbVKRVtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 16:49:03 -0500
Received: from mail.kroah.org ([69.55.234.183]:57047 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932197AbVKRVtB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 16:49:01 -0500
Date: Fri, 18 Nov 2005 13:20:32 -0800
From: Greg KH <greg@kroah.com>
To: Dave Jones <davej@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
Subject: Re: [linux-pm] [RFC] userland swsusp
Message-ID: <20051118212032.GA23950@kroah.com>
References: <20051115212942.GA9828@elf.ucw.cz> <20051115222549.GF17023@redhat.com> <1132342590.25914.86.camel@localhost.localdomain> <20051118211847.GA3881@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051118211847.GA3881@redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2005 at 04:18:47PM -0500, Dave Jones wrote:
> Even if that was capable however, it still doesn't solve the problem.
> Pavel's implementation wants to write to arbitary address spaces, which is
> what we're trying to prevent. The two are at odds with each other.

I agree, he needs to find a different way to get that information into
and out of the kernel than that device node for it to be accepted into
mainline.  But for now, it's a nice way to mock up the fuctionality
needed.

thanks,

greg k-h
