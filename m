Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274904AbTHPTQM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 15:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274908AbTHPTQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 15:16:12 -0400
Received: from mail.kroah.org ([65.200.24.183]:45762 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S274904AbTHPTQJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 15:16:09 -0400
Date: Sat, 16 Aug 2003 12:16:31 -0700
From: Greg KH <greg@kroah.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test3 current - firewire compile error
Message-ID: <20030816191631.GB14960@kroah.com>
References: <3F3E288B.3010105@cornell.edu> <20030816163553.GA9735@kroah.com> <87wuddzenr.fsf@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wuddzenr.fsf@devron.myhome.or.jp>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 17, 2003 at 02:38:16AM +0900, OGAWA Hirofumi wrote:
> Greg KH <greg@kroah.com> writes:
> 
> > I removed struct device.name and forgot to change the firewire code :(
> > 
> > I'll work on a patch for this later this evening, unless someone beats
> > me to it.
> 
> Why wasn't DEVICE_NAME_SIZE/_HALF killed? Looks like these also should
> define by drivers.

Some subsystems use that #define for their device name size.  Yeah, it
probably could be gotten rid of too, just didn't really see the need.

Patches are always welcome if you want to fix this up.  :)

thanks,

greg k-h
