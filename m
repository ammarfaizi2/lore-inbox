Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264254AbUACWQH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 17:16:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264272AbUACWQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 17:16:06 -0500
Received: from mail.kroah.org ([65.200.24.183]:65166 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264254AbUACWQE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 17:16:04 -0500
Date: Sat, 3 Jan 2004 14:11:22 -0800
From: Greg KH <greg@kroah.com>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: udev and devfs - The final word
Message-ID: <20040103221121.GI11061@kroah.com>
References: <20031231002942.GB2875@kroah.com> <20040101011855.GA13628@hh.idb.hist.no> <20040103055938.GD5306@kroah.com> <20040103152241.GA5531@hh.idb.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040103152241.GA5531@hh.idb.hist.no>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 03, 2004 at 04:22:41PM +0100, Helge Hafting wrote:
> > Hopefully I can work on fixing this up in 2.7.
> 
> Interesting - how do you plan to do this?  

Probably something like the current interface for USB minor numbers when
CONFIG_USB_DYNAMIC_MINORS is enabled.  The drivers will request a
certian major/minor, but the kernel will just give it whatever it feels
like.

That's my first guess, actual implementation will probably differ wildly
:)

thanks,

greg k-h
