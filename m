Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262362AbTE2QlF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 12:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262363AbTE2QlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 12:41:04 -0400
Received: from granite.he.net ([216.218.226.66]:38153 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S262362AbTE2QlD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 12:41:03 -0400
Date: Thu, 29 May 2003 09:56:24 -0700
From: Greg KH <greg@kroah.com>
To: Paul Fulghum <paulkf@microgate.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "torvalds@transmeta.com" <torvalds@transmeta.com>
Subject: Re: [PATCH] 2.5.70 tty_register_driver
Message-ID: <20030529165623.GC19920@kroah.com>
References: <1054138158.2107.4.camel@diemos> <1054150058.2025.18.camel@diemos> <1054218448.2099.5.camel@diemos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1054218448.2099.5.camel@diemos>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 29, 2003 at 09:27:28AM -0500, Paul Fulghum wrote:
> This patch corrects changes made in 2.5.70 to
> tty_register_device() which caused the device
> minor base specified by tty drivers using dynamically
> allocated device major number to be ignored.
> 
> I have posted to lkml and to the originator of the
> 2.5.70 patch, and have received no dissenting views.

Hm, I wasn't the originator of the 2.5.70 change in this area, that's Al
Viro.  I suggest you run this by him first.

thanks,

greg k-h
