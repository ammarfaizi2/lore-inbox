Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751247AbWFTFSK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbWFTFSK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 01:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbWFTFSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 01:18:10 -0400
Received: from mail.kroah.org ([69.55.234.183]:33685 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751247AbWFTFSI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 01:18:08 -0400
Date: Mon, 19 Jun 2006 16:53:55 -0700
From: Greg KH <greg@kroah.com>
To: Daniele Orlandi <daniele@orlandi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Passing references to kobjects between userland and kernel
Message-ID: <20060619235355.GA26685@kroah.com>
References: <200606141626.39273.daniele@orlandi.com> <20060616235800.GA29573@kroah.com> <200606200148.56117.daniele@orlandi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606200148.56117.daniele@orlandi.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2006 at 01:48:54AM +0200, Daniele Orlandi wrote:
> On Saturday 17 June 2006 01:58, Greg KH wrote:
> >
> > Use the kobject_uevent() call from kernelspace to let userspace know
> > whatever you want it to.  That is what it is there for :)
> 
> kobject_uevent() is fine if I want to asynchronously notify the user space of 
> an event.
> 
> What I need is a synchronous bidirectional interface, e.g. I tell the kernel 
> "connect node X with node Y" and I get back the resulting pipeline 
> identifier.

Why do you feel that this is a requirement?  What exactly are you trying
to do?

thanks,

greg k-h
