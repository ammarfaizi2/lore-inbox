Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264481AbTKNBqq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 20:46:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264495AbTKNBqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 20:46:46 -0500
Received: from mail.kroah.org ([65.200.24.183]:19354 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264481AbTKNBqp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 20:46:45 -0500
Date: Thu, 13 Nov 2003 17:45:21 -0800
From: Greg KH <greg@kroah.com>
To: Olaf Hering <olh@suse.de>
Cc: "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: USB-keyboard not recognized when not connected during startup
Message-ID: <20031114014521.GV16352@kroah.com>
References: <3FAFDA82.864DC1BE@orpatec.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FAFDA82.864DC1BE@orpatec.ch>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 10, 2003 at 07:35:47PM +0100, Otto Wyss wrote:
> Please CC, I'm not subscribed.
> 
> I use an USB-keyboard via an USB-switchbox on 2 computers (PC and Mac).
> When I boot into Windows or MacOS9 it doesn't matter whether my USB is
> connected, the keyboard gets recognized when the connection happens. Not
> so on Linux (PC), there the keyboard gets only recognized if it's
> connected during startup. If I forget to switch the keyboard to the PC
> before I start Linux, it isn't recognized and unusable. This is mostly
> annoying because I can't get rid of my AT-keyboard and just use the
> USB-keyboard, a none working keyboard is identical to a system crash!
> When the USB-keyboard is connected during startup everything is okay.

Do you have something like "USB Legacy support" enabled in your BIOS?
Or it might be called something else.  Try disabling that.

Good luck,

greg k-h
