Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbTE2GwT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 02:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261936AbTE2GwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 02:52:18 -0400
Received: from granite.he.net ([216.218.226.66]:16645 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S261932AbTE2GwR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 02:52:17 -0400
Date: Wed, 28 May 2003 23:47:22 -0700
From: Greg KH <greg@kroah.com>
To: Florian Lohoff <flo@rfc822.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.69/i386] rmmod ohci_hcd - deadlock
Message-ID: <20030529064722.GB5603@kroah.com>
References: <20030527130421.GB701@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030527130421.GB701@paradigm.rfc822.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 27, 2003 at 03:04:21PM +0200, Florian Lohoff wrote:
> 
> Hi,
> i am seeing a deadlock on removal of the ohci_hcd module. You get to see
> some usb disconnect messages after which the machine is dead and needs
> to be powercycled. This is a Sony Vaio C1MHP. I am unable to test 2.5.70
> because it hangs on boot with unhandled IRQs.

This should be fixed in 2.5.70.  If not, please let us know.

thanks,

greg k-h
