Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262906AbUB0SSy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 13:18:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262931AbUB0SSy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 13:18:54 -0500
Received: from mail.kroah.org ([65.200.24.183]:32158 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262906AbUB0SSs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 13:18:48 -0500
Date: Fri, 27 Feb 2004 10:18:48 -0800
From: Greg KH <greg@kroah.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Alexander Viro <aviro@redhat.com>, "David S. Miller" <davem@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Sysfs is too restrictive
Message-ID: <20040227181848.GB9891@kroah.com>
References: <20040227100541.284fb155@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040227100541.284fb155@dell_ss3.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 27, 2004 at 10:05:41AM -0800, Stephen Hemminger wrote:
> 
> It is too hard to get the desired directory layout without re-implementing most
> of sysfs in the driver.  This is what I want, and don't have Pat to kick around
> anymore.

Yes, I agree that it needs to be made much easier to create a
subdirectory in sysfs using the driver model.  I even filed a bug about
that a long time ago :)

It's on my TODO list for 2.7, if that makes you feel any better.  And if
you want to try to implement it before I get to it, that would be great.

Sorry I don't have a solution for you to do this with today :(

greg k-h
