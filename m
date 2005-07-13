Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262720AbVGMVBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262720AbVGMVBg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 17:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262717AbVGMU7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 16:59:09 -0400
Received: from mail.kroah.org ([69.55.234.183]:38067 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262769AbVGMU5g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 16:57:36 -0400
Date: Wed, 13 Jul 2005 13:53:16 -0700
From: Greg KH <greg@kroah.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: usb mass storage bug
Message-ID: <20050713205316.GA16238@kroah.com>
References: <20050711203047.39437.qmail@web33113.mail.mud.yahoo.com> <mailman.1121138161.21500.linux-kernel2news@redhat.com> <20050712225013.2e66d0fc.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050712225013.2e66d0fc.zaitcev@redhat.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2005 at 10:50:13PM -0700, Pete Zaitcev wrote:
> On Mon, 11 Jul 2005 20:09:58 -0700, Greg KH <greg@kroah.com> wrote:
> > On Mon, Jul 11, 2005 at 01:30:47PM -0700, Joe Sevy wrote:
> > > Sorry, no logs or dmesg to report; just performance.
> > > Using kernel 2.6.12: USB flash drive (san-disk cruzer
> > > micro) Copy FROM drive is normal and quick; copy TO
> > > drive is amazingly slow. (30 minutes for 50K file).
> > > Used same configuration as for 2.6.11.11. Cured by
> > > going back to old kernel.
> > 
> > Are you using CONFIG_UB or CONFIG_USB_STORAGE?
> 
> Please, Greg. I knew that someone will try to implicate ub here, but you?

Heh, sorry, I didn't really pay attention for the time ammounts, only
that he reported things slower.

You are right, ub isn't _that_ slow at all, I use it all the time on
some of my devices just fine.

thanks,

greg k-h
