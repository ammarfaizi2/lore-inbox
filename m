Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267089AbTGKXRT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 19:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267091AbTGKXRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 19:17:19 -0400
Received: from mail.kroah.org ([65.200.24.183]:38795 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267089AbTGKXRS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 19:17:18 -0400
Date: Fri, 11 Jul 2003 16:29:44 -0700
From: Greg KH <greg@kroah.com>
To: Ronald Jerome <imun1ty@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: generate-modprobe question and USB fatal error during INIT:-resending
Message-ID: <20030711232944.GL23240@kroah.com>
Reply-To: linux-kernel@vger.kernel.org
References: <20030711222712.GC23189@kroah.com> <20030711232612.64205.qmail@web13310.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030711232612.64205.qmail@web13310.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 11, 2003 at 04:26:12PM -0700, Ronald Jerome wrote:
> I don't have any patch at the moment.  Still trying to
> figure out why I cannot get the USB mouse nor USB
> keyboard HID devices to load during the INIT:

Just use the HID driver, do NOT use the usbkb or usbmouse drivers.  Read
the config help entries for those drivers for why you don't want to do
that.

thanks,

greg k-h
