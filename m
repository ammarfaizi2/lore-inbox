Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263632AbTIHWKv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 18:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263678AbTIHWKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 18:10:51 -0400
Received: from mail.kroah.org ([65.200.24.183]:5821 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263632AbTIHWKt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 18:10:49 -0400
Date: Mon, 8 Sep 2003 15:11:02 -0700
From: Greg KH <greg@kroah.com>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: problem with "Gadget filesystem" config prompt (bk10)
Message-ID: <20030908221102.GA2953@kroah.com>
References: <Pine.LNX.4.44.0309081137260.15517-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309081137260.15517-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 08, 2003 at 11:40:46AM -0400, Robert P. J. Day wrote:
> 
>   just doing a "make oldconfig", from bk9 -> bk10, being prompted for the
> USB_GADGETFS (Gadget filesystem), which asks
> 
>   ... [N/m/?]  (NEW)
> 
> without thinking, i typed "y" (not noticing that that was not a valid
> answer), and what i got back was:
> 
> Say "y" to link the driver statically, or "m" to build a
> dynamically linked module called "gadgetfs".
> 
>   which suggests that "y" *is* a valid response (when clearly it isn't).  
> someone might want to clarify this.

You got the help information for this option.  And "y" is a valid option
if one of the parent options is selected as "y".  Not much you can do
here...

thanks,

greg k-h
