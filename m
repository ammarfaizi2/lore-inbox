Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267792AbUBRSqO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 13:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267829AbUBRSoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 13:44:14 -0500
Received: from mail.kroah.org ([65.200.24.183]:18084 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267828AbUBRSoE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 13:44:04 -0500
Date: Wed, 18 Feb 2004 09:55:41 -0800
From: Greg KH <greg@kroah.com>
To: "Hayden A. James" <hjames@quantumcode.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB access via KVM broken in 2.6[0-3]
Message-ID: <20040218175540.GB2924@kroah.com>
References: <1077081034.6813.22.camel@haydend.quantumcode.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1077081034.6813.22.camel@haydend.quantumcode.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 18, 2004 at 12:10:34AM -0500, Hayden A. James wrote:
> I don't know what happened between 2.4.x and the latest 2.6.x release
> but USB access to my keyboard and mouse from my USB KVM (Ioport
> miniview) does NOT work at all for any of the devices.  The devices work
> normally in 2.6 without having the kvm connected, however.  Is this an
> already known issue?

Yes, some people have reported problems with some brands of USB KVM
devices.  Do you get some "timeout" style messages when your devices
stop working?  Odds are the devices are way out of spec...

Try enabling CONFIG_USB_DEBUG and post the messages to the
linux-usb-devel mailing list.

thanks,

greg k-h
