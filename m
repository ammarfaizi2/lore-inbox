Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263440AbUDZUUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263440AbUDZUUT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 16:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263444AbUDZUUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 16:20:19 -0400
Received: from mail.kroah.org ([65.200.24.183]:42889 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263440AbUDZUUI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 16:20:08 -0400
Date: Mon, 26 Apr 2004 12:53:59 -0700
From: Greg KH <greg@kroah.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: "E. Oltmanns" <oltmanns@uni-bonn.de>, linux-kernel@vger.kernel.org
Subject: Re: Kernel Oops during usb usage (2.6.5)
Message-ID: <20040426195359.GA29062@kroah.com>
References: <20040423205617.GA1798@local> <20040424003013.GA13631@kroah.com> <408D4187.2040104@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <408D4187.2040104@tmr.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2004 at 01:06:15PM -0400, Bill Davidsen wrote:
> 
> Just in general, if there is anything a non-root user can do to crash 
> the system, it's probably a kernel bug by definition. It doesn't matter 
> that's it a stupid thing to do, it might be malicious. And in this case 
> it might just be user error.

But you either have to be root in order to talk to usbfs, or you were
root when you gave a user access to the usbfs node.  So either way, a
"normal" user can't even do this.

thanks,

greg k-h
