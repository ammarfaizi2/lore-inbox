Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263753AbTDXQUg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 12:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263754AbTDXQUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 12:20:36 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:41605 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263753AbTDXQUe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 12:20:34 -0400
Date: Thu, 24 Apr 2003 09:11:56 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.68, khubd oops upon USB flash drive removal
Message-ID: <20030424161156.GA24633@kroah.com>
References: <20030424152556.GA11972@iarc.uaf.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030424152556.GA11972@iarc.uaf.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 24, 2003 at 07:25:56AM -0800, Christopher Swingley wrote:
> Greetings,
> 
> I reported this for 2.5.67 as well.  Repeatable on more than one sort of 
> i386 machine (P3, K7).  Insert USB flash drive, mount drive, unmount 
> drive, remove USB device, kernel oops.  Kernel keeps running, but USB is 
> dead.  Here's the oops from /var/log/kern.log.  I have symbol 
> information in the kernel, which (correct me if I'm wrong!) means I 
> don't need ksymoops, right?

Looks like a scsi bug :)

Want to file this in bugzilla.kernel.org so that we can be sure to track
it and assign it to someone who can fix it?

thanks,

greg k-h
