Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262288AbUCCAZb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 19:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262274AbUCCAZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 19:25:31 -0500
Received: from mail.kroah.org ([65.200.24.183]:61075 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262290AbUCCAZQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 19:25:16 -0500
Date: Tue, 2 Mar 2004 16:25:17 -0800
From: Greg KH <greg@kroah.com>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 021 release
Message-ID: <20040303002517.GB15036@kroah.com>
References: <20040303000957.GA11755@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040303000957.GA11755@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2004 at 04:09:57PM -0800, Greg KH wrote:
> I've released the 021 version of udev.  It can be found at:
>  	kernel.org/pub/linux/utils/kernel/hotplug/udev-021.tar.gz

Two other things about this release that Kay just reminded me about:
	- if you have been using the tarballs, please delete
	  /sbin/udevinfo by hand, as it is now placed in
	  /usr/bin/udevinfo.  Users who use the rpm or some other kind
	  of package system will have no problems with this.
	  
	- the old style %2c format has now been removed in favor of the
	  %c{2} style.  Any old udev.rules files will need to be
	  converted (you had a few releases to do this...)
	  
And another one I just remembered:
	- we now support multiple symlink rules.  They aren't really
	  documented well, but hopefully the author of that patch will
	  fix this soon...


thanks,

greg k-h
