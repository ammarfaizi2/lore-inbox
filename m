Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262906AbTDRH2p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 03:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262911AbTDRH2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 03:28:45 -0400
Received: from granite.he.net ([216.218.226.66]:19972 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S262906AbTDRH2o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 03:28:44 -0400
Date: Fri, 18 Apr 2003 00:39:00 -0700
From: Greg KH <greg@kroah.com>
To: Frode Isaksen <fisaksen@bewan.com>
Cc: weissg@vienna.at, linux-kernel@vger.kernel.org
Subject: Re: PATCH: usb-ohci: interrupt out with urb->interval 0
Message-ID: <20030418073900.GB2753@kroah.com>
References: <6451EBA9-7022-11D7-8F05-003065EF6010@bewan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6451EBA9-7022-11D7-8F05-003065EF6010@bewan.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 16, 2003 at 05:45:04PM +0200, Frode Isaksen wrote:
> In the usb-ohci driver, the interrupt out transfer is always 
> rescheduled, even if the urb->interval is set to 0 to signal a one-shot 
> transfer.
> The other usb drivers (usb-uhci,uhci) allows one-shot interrupt out 
> transfers.
> Tested with kernel 2.4.21 and previous kernels.

Again, there is no 2.4.21, and your patch doesn't apply against the
latest 2.4.21-pre7 tree.

thanks,

greg k-h
