Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270352AbTHGQew (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 12:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270354AbTHGQew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 12:34:52 -0400
Received: from mail.kroah.org ([65.200.24.183]:1938 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270352AbTHGQet (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 12:34:49 -0400
Date: Thu, 7 Aug 2003 09:30:57 -0700
From: Greg KH <greg@kroah.com>
To: Stuart Longland <stuartl@longlandclan.hopto.org>
Cc: Linux Lernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Problems with Yamaha opl3sa2 under 2.4.20 and ongoing PCMCIA & USB problems on 2.6.0-test2
Message-ID: <20030807163057.GB11433@kroah.com>
References: <3F32417D.3090000@longlandclan.hopto.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F32417D.3090000@longlandclan.hopto.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 07, 2003 at 10:09:33PM +1000, Stuart Longland wrote:
> 	- My USB 2.0 hard drive box (aka IDE-TO-USB) does not function.  It
> detects it, and automatically loads usb_storage, but I get an error
> message saying the device was not found.

What are the exact kernel log messages you got?
What does /proc/bus/usb/devices show when the device is plugged in?
Do you have SCSI disk support built into your kernel or loaded as a
module?

thanks,

greg k-h
