Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262007AbULPTSP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262007AbULPTSP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 14:18:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbULPTQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 14:16:23 -0500
Received: from mail.kroah.org ([69.55.234.183]:17344 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261999AbULPTI5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 14:08:57 -0500
Date: Thu, 16 Dec 2004 11:08:35 -0800
From: Greg KH <greg@kroah.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: debugfs in the namespace
Message-ID: <20041216190835.GE5654@kroah.com>
References: <20041216110002.3e0ddf52@lembas.zaitcev.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041216110002.3e0ddf52@lembas.zaitcev.lan>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2004 at 11:00:02AM -0800, Pete Zaitcev wrote:
> Hi Greg,
> 
> what is the canonic place to mount debugfs: /debug, /debugfs, or anything
> else? The reason I'm asking is that USBMon has to find it somewhere and
> I'd really hate to see it varying from distro to distro.

Hm, in my testing I've been putting it in /dbg, but I don't like vowels :)

Anyway, I don't really know.  /dev/debug/ ?  /proc/debug ?  /debug ?

What do people want?  I guess it's time to write up a LSB proposal :(

thanks,

greg k-h
