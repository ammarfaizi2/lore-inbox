Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbUDITFw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 15:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbUDITFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 15:05:52 -0400
Received: from mail.kroah.org ([65.200.24.183]:44737 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261661AbUDITFt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 15:05:49 -0400
Date: Fri, 9 Apr 2004 11:53:56 -0700
From: Greg KH <greg@kroah.com>
To: Hanna Linder <hannal@us.ibm.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       braam@cs.cmu.edu, coda@cs.cmu.edu
Subject: Re: [PATCH 2.6.5] Add sysfs class support to fs/coda/psdev.c
Message-ID: <20040409185356.GC17187@kroah.com>
References: <7290000.1081457670@dyn318071bld.beaverton.ibm.com> <7970000.1081458781@dyn318071bld.beaverton.ibm.com> <1081461739.5880.13.camel@pegasus> <9260000.1081464415@w-hlinder.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9260000.1081464415@w-hlinder.beaverton.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2004 at 03:46:55PM -0700, Hanna Linder wrote:
> --On Friday, April 09, 2004 12:02:19 AM +0200 Marcel Holtmann <marcel@holtmann.org> wrote:
> 
> >> +static struct class_simple coda_psdev_class;
> > 
> > I think coda_psdev_class must be a pointer.
> > 
> > Regards
> > 
> > Marcel
> 
> 
> Doh! I tested on one system and fixed this there. Then accidentally mailed out the
> original. Sorry about that. Here is a patch to fix it:

Applied, thanks.

greg k-h
