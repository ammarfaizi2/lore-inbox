Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1160998AbWARVEj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160998AbWARVEj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 16:04:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030471AbWARVEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 16:04:39 -0500
Received: from mail.kroah.org ([69.55.234.183]:39064 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030470AbWARVEi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 16:04:38 -0500
Date: Wed, 18 Jan 2006 13:04:05 -0800
From: Greg KH <greg@kroah.com>
To: David R <david@unsolicited.net>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.16-rc1
Message-ID: <20060118210405.GA4682@kroah.com>
References: <Pine.LNX.4.64.0601170001530.13339@g5.osdl.org> <43CD4504.8020705@unsolicited.net> <20060118045930.GC7292@kroah.com> <43CEABBD.2050604@unsolicited.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43CEABBD.2050604@unsolicited.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2006 at 08:57:33PM +0000, David R wrote:
> Greg KH wrote:
> >> dmesg etc looks ok. I'd appreciate it if anyone has any thoughts?
> > 
> > Nothing has changed in usbfs that might cause this that I know of.  Can
> > you use git to bisect what patch caused it?
> > 
> > thanks,
> > 
> > greg k-h
> 
> And indeed nothing had changed. There was a runaway process using 100% of the
> CPU causing the symptoms. After gently bashing my boot scripts around
> everything seems to work just fine. So, RC1 seems 100% on my setup.

Great, thanks for letting us know.

greg k-h
