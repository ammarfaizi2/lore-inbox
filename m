Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261998AbVEKRIG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261998AbVEKRIG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 13:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262004AbVEKRIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 13:08:06 -0400
Received: from mail.kroah.org ([69.55.234.183]:52418 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261998AbVEKRH5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 13:07:57 -0400
Date: Wed, 11 May 2005 10:04:28 -0700
From: Greg KH <greg@kroah.com>
To: Yani Ioannou <yani.ioannou@gmail.com>
Cc: LM Sensors <sensors@stimpy.netroedge.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.12-rc4 2/3] (dynamic sysfs callbacks) device_attribute
Message-ID: <20050511170428.GC15398@kroah.com>
References: <253818670505110057b96cf62@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <253818670505110057b96cf62@mail.gmail.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2005 at 03:57:29AM -0400, Yani Ioannou wrote:
> Hi,
> 
> This second patch removes the "initialization from incompatible
> pointer type" warnings resulting from the code using the old callback
> function signatures. It is mainly auto-generated (see inlined
> shell/perl scripts below), and is 308K so I'm linking to it:
> 
> http://osdn.dl.sourceforge.net/sourceforge/bmcsensors-26/patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn.diff
> 
> Note that the diffstat # of changes (approx # of sysfs callbacks)
> gives you some idea of which drivers will most benefit from this
> patch.
> 
> Signed-off-by: Yani Ioannou <yani.ioannou@gmail.com>
> 

Sorry, but I need a real patch in email form so I can apply it.  I can
handle a 300K+ email :)

Or you can break it up into smaller pieces, like one per major part of
the kernel.  That is the preferred way.

thanks,

greg k-h
