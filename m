Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261270AbVC0SNH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbVC0SNH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 13:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbVC0SNH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 13:13:07 -0500
Received: from mail.kroah.org ([69.55.234.183]:27032 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261270AbVC0SNE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 13:13:04 -0500
Date: Sun, 27 Mar 2005 10:10:56 -0800
From: Greg KH <greg@kroah.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Mark Fortescue <mark@mtfhpc.demon.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: Can't use SYSFS for "Proprietry" driver modules !!!.
Message-ID: <20050327181056.GA14502@kroah.com>
References: <Pine.LNX.4.10.10503261710320.13484-100000@mtfhpc.demon.co.uk> <20050326182828.GA8540@kroah.com> <1111869274.32641.0.camel@mindpipe> <20050327004801.GA610@kroah.com> <1111885480.1312.9.camel@mindpipe> <20050327032059.GA31389@kroah.com> <1111894220.1312.29.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111894220.1312.29.camel@mindpipe>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 26, 2005 at 10:30:20PM -0500, Lee Revell wrote:
> On Sat, 2005-03-26 at 19:20 -0800, Greg KH wrote:
> > > Anyway, this is news to me.  How about putting it in the FAQ?  Too
> > > politically charged?
> > 
> > Why does it need to be in the FAQ, when the file COPYING in the main
> > kernel directory explicitly spells this out?
> 
> That's the problem, it's not spelled out explicitly anywhere.  That file
> does not address the issue of whether a driver is a "derived work".
> This is the part he should talk to a lawyer about, right?

How about the fact that when you load a kernel module, it is linked into
the main kernel image?  The GPL explicitly states what needs to be done
for code linked in.

Also, realize that you have to use GPL licensed header files to build
your kernel module...

greg k-h
