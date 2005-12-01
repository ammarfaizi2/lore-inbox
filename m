Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932489AbVLAVfP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932489AbVLAVfP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 16:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932492AbVLAVfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 16:35:15 -0500
Received: from mail.kroah.org ([69.55.234.183]:52368 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932489AbVLAVfN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 16:35:13 -0500
Date: Thu, 1 Dec 2005 13:34:31 -0800
From: Greg KH <greg@kroah.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: mousedev auto load on 2.6.14-rc{2,3}
Message-ID: <20051201213431.GA22439@kroah.com>
References: <1133464818.7130.27.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133464818.7130.27.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2005 at 02:20:18PM -0500, Steven Rostedt wrote:
> Hi,
> 
> Using the same config between 2.6.14 and 2.6.15-rc2 (and with rc3,
> haven't tried rc4). The mousedev gets auto loaded on 2.6.14 but does not
> with 2.6.15-rc{2,3}.  Did something change to prevent the auto loading
> of mousedev?

This needs to be a FAQ somewhere.  This is a known bug in Debian's
hotplug/udev package that is being worked on.

It's not a kernel bug, but a userspace one.  Other distros do not have
this issue, perhaps I could recommend a different one for you?  :)

thanks,

greg k-h
