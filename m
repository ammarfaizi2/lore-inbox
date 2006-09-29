Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965047AbWI2AMe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965047AbWI2AMe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 20:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965051AbWI2AMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 20:12:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23962 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965047AbWI2AMd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 20:12:33 -0400
Date: Thu, 28 Sep 2006 17:12:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <gregkh@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [GIT PATCH] More USB patches for 2.6.18
Message-Id: <20060928171218.3ff99ec5.akpm@osdl.org>
In-Reply-To: <20060929000524.GA1625@suse.de>
References: <20060928224250.GA23841@kroah.com>
	<Pine.LNX.4.64.0609281639040.3952@g5.osdl.org>
	<20060928165951.2c5bd4c7.akpm@osdl.org>
	<20060929000524.GA1625@suse.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Sep 2006 17:05:24 -0700
Greg KH <gregkh@suse.de> wrote:

> >  
> > +#ifdef CONFIG_PM
> > +static int ohci_restart(struct ohci_hcd *ohci);
> > +#endif
> 
> That #ifdef shouldn't be even needed.

We'll get "warning: 'ohci_restart' declared 'static' but never defined"
without it.
