Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270859AbTHATqV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 15:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274962AbTHATok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 15:44:40 -0400
Received: from mail.kroah.org ([65.200.24.183]:31681 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S274960AbTHAToH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 15:44:07 -0400
Date: Fri, 1 Aug 2003 12:44:06 -0700
From: Greg KH <greg@kroah.com>
To: Samuel Flory <sflory@rackable.com>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-pre10 compile failure  USB HID
Message-ID: <20030801194406.GA31510@kroah.com>
References: <3F2AC00C.1010203@rackable.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F2AC00C.1010203@rackable.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 01, 2003 at 12:31:24PM -0700, Samuel Flory wrote:
>  I'm seeing a linking issue when I compile USB HID support directly 
> into the kernel.  Looking at my kernel config it looks like it might 
> have something to do with the fact that I'm compiling CONFIG_INPUT, 
> CONFIG_INPUT_KEYBDEV, and CONFIG_INPUT_MOUSEDEV as modules.  Should 
> CONFIG_USB_HID depend on one, or all of the above.

Yes, that configuration will not work.  I think this has been discussed
many times on the lists in the past, and the end agreement is, "Don't
try to do that." :)

It's not an easy configuration language fix from what I remember.

thanks,

greg k-h
