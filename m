Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261917AbULKCc7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261917AbULKCc7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 21:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261915AbULKCc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 21:32:59 -0500
Received: from mail.kroah.org ([69.55.234.183]:1190 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261918AbULKCcz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 21:32:55 -0500
Date: Fri, 10 Dec 2004 18:32:43 -0800
From: Greg KH <greg@kroah.com>
To: Roland Dreier <roland@topspin.com>
Cc: David Brownell <david-b@pacbell.net>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] [RFC PATCH] debugfs - yet another in-kernel file system
Message-ID: <20041211023243.GA18663@kroah.com>
References: <20041210005055.GA17822@kroah.com> <200412101729.01155.david-b@pacbell.net> <20041211013930.GB12846@kroah.com> <52is797eom.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52is797eom.fsf@topspin.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2004 at 06:26:49PM -0800, Roland Dreier wrote:
>     Greg> I considered adding a kobject as a paramater to the debugfs
>     Greg> interface.  The file created would be equal to the path that
>     Greg> the kobject has.  Would that work for you?
> 
> I'd really prefer this to be optional at least.  Somethings it's nice
> to use kobjects for, but creating hierarchies of subdirectories is not
> really one of them.

Oh yes, it would be optional.  I still like the simple interface that
debugfs is providing so far, I'll just add
yet-another-way-to-create-a-file type function that takes a kobject.

Sound ok?

thanks,

greg k-h
