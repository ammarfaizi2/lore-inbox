Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262215AbUENTMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262215AbUENTMq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 15:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262238AbUENTMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 15:12:46 -0400
Received: from mail.kroah.org ([65.200.24.183]:4587 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262215AbUENTMi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 15:12:38 -0400
Date: Fri, 14 May 2004 12:11:13 -0700
From: Greg KH <greg@kroah.com>
To: David Brownell <david-b@pacbell.net>
Cc: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm2, usb ehci warnings/error?
Message-ID: <20040514191113.GD2620@kroah.com>
References: <40A3962F.3020500@pacbell.net> <40A47AC3.4010403@gmx.de> <40A4FC1A.20809@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40A4FC1A.20809@pacbell.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2004 at 10:04:26AM -0700, David Brownell wrote:
> Prakash K. Cheemplavam wrote:
> >David Brownell wrote:
> >
> >>>There appear lines like
> >>>
> >>>usb usb2: string descriptor 0 read error: -108
> >>>
> >>>bug or feature? They weren't there with 2.6.6-mm1. I have no usb2.0 
> >>>stuff to actually test. My usb1 stuff seems to work though.
> >>
> >>Bug; minor, since the only real symptom seems to be messages like
> >>that.  Ignore them for now, I'll make a patch soonish.
> >
> >Ok, good. Thanks for the explanation of what is going on, though I don't 
> >can make too much out of it. ;-)
> 
> The short version is:  it's missing this patch.
> 
> [ Greg, please merge! ]

Applied, thanks.

greg k-h
