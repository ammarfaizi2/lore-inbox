Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161008AbWJ3FQU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161008AbWJ3FQU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 00:16:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161018AbWJ3FQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 00:16:20 -0500
Received: from smtp.osdl.org ([65.172.181.4]:58278 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161008AbWJ3FQT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 00:16:19 -0500
Date: Sun, 29 Oct 2006 21:16:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc3-mm1
Message-Id: <20061029211604.41114b13.akpm@osdl.org>
In-Reply-To: <20061030035430.GA4045@kroah.com>
References: <20061029160002.29bb2ea1.akpm@osdl.org>
	<20061030025000.GA8896@redhat.com>
	<20061030035430.GA4045@kroah.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Oct 2006 19:54:30 -0800
Greg KH <greg@kroah.com> wrote:

> On Sun, Oct 29, 2006 at 09:50:00PM -0500, Dave Jones wrote:
> > On Sun, Oct 29, 2006 at 04:00:02PM -0800, Andrew Morton wrote:
> > 
> >  > - For some reason Greg has resurrected the patches which detect whether
> >  >   you're using old versions of udev and if so, punish you for it.
> >  > 
> >  >   If weird stuff happens, try upgrading udev.
> > 
> > Where "old" is how old exactly ?
> 
> As per the Kconfig help entry, any version of udev released before 2006
> will probably have problems with the new config option.  So follow the
> text and enable the option if you are running an old version of udev and
> you should be fine.

<hunts>

Greg is referring to CONFIG_SYSFS_DEPRECATED.  I didn't know it existed. 
If I had known I'd have saved maybe an hour and I perhaps wouldn't have had
to revert gregkh-driver-tty-device.patch

What mailing list was this discussed and reviewed on?

The option should default to "y".

The changelog is wrong.  Or garbled.  Certainly confusing.

