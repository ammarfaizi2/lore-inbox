Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261707AbULTXni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261707AbULTXni (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 18:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbULTXmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 18:42:22 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:55715 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261678AbULTXkY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 18:40:24 -0500
Date: Mon, 20 Dec 2004 15:40:13 -0800
From: Greg KH <greg@kroah.com>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] convert struct usb_device_descriptor to native endian
Message-ID: <20041220234013.GB21870@kroah.com>
References: <20041220233904.GA21870@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041220233904.GA21870@kroah.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2004 at 03:39:04PM -0800, Greg KH wrote:
> As discussed last week, (see
> http://article.gmane.org/gmane.linux.kernel/262089 for the thread) I've
> committed the following patch to the USB bk trees.  
> 
> Consider this a "heads up" for any USB drivers that are outside of the
> main kernel tree (and if there are any, why not submit them for
> inclusion?)

Note, I didn't fix up the usb gadget drivers yet, they still need a bit
more work to be sparse clean.  I'll be doing that, and changing the
remaining 16bit USB data fields next, but those changes will not be as
intrusive or as big as this one was.

thanks,

greg k-h
