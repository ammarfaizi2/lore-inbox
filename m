Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030637AbVJ1Tq3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030637AbVJ1Tq3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 15:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030332AbVJ1Tq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 15:46:26 -0400
Received: from mail.kroah.org ([69.55.234.183]:35018 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030313AbVJ1TqZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 15:46:25 -0400
Date: Fri, 28 Oct 2005 12:45:28 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, david-b@pacbell.net,
       torvalds@osdl.org
Subject: Re: [PATCH] pci device wakeup flags
Message-ID: <20051028194528.GA17326@kroah.com>
References: <11304810221338@kroah.com> <11304810223093@kroah.com> <20051028035116.112ba2ca.akpm@osdl.org> <20051028155044.GA11924@kroah.com> <20051028123434.09c5cb2f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051028123434.09c5cb2f.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2005 at 12:34:34PM -0700, Andrew Morton wrote:
> Greg KH <greg@kroah.com> wrote:
> >
> > I
> >  thought that it was one of the usb patches in my tree that was causing
> >  you problems.
> 
> That's a separate problem.  gregkh-usb-usb-pm-09.patch causes my x86 box to
> hang partway though boot.  I drop that from -mm as well.

Ugh, ok, at least I wasn't that far off.  I'll make sure to not send the
usb pm patches in the round of usb updates until that gets figured out.

thanks,

greg k-h

