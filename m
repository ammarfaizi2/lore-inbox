Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261465AbTIBQ6M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 12:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261447AbTIBQ6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 12:58:12 -0400
Received: from mail.kroah.org ([65.200.24.183]:41395 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264032AbTIBQxq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 12:53:46 -0400
Date: Tue, 2 Sep 2003 02:28:23 -0700
From: Greg KH <greg@kroah.com>
To: biker@villagepeople.it
Cc: linux-kernel@vger.kernel.org
Subject: Re: pl2303 + uhci oops
Message-ID: <20030902092823.GA15451@kroah.com>
References: <200309011400.08914.biker@villagepeople.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309011400.08914.biker@villagepeople.it>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 01, 2003 at 02:00:08PM +0200, biker@villagepeople.it wrote:
> Hello everybody!
> Using a pl2303-based usb->serial adaptor with the uhci driver always ends with 
> a oops.

As has been already reported, this is a known bug, sorry.

And sorry, but I don't know of anyone backporting the fixes that are
needed for this to the 2.4 kernel from the changes made in 2.6.  See
the archives of this list, or linux-usb-devel or linux-usb-users for
more details about the oops and what changes need to be made for 2.4.

greg k-h
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
On Mon, Sep 01, 2003 at 02:00:08PM +0200, biker@villagepeople.it wrote:
> Hello everybody!
> Using a pl2303-based usb->serial adaptor with the uhci driver always ends with 
> a oops.

As has been already reported, this is a known bug, sorry.

And sorry, but I don't know of anyone backporting the fixes that are
needed for this to the 2.4 kernel from the changes made in 2.6.  See
the archives of this list, or linux-usb-devel or linux-usb-users for
more details about the oops and what changes need to be made for 2.4.

greg k-h
