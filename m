Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263519AbUCTTxk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 14:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263526AbUCTTxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 14:53:40 -0500
Received: from mail.kroah.org ([65.200.24.183]:58513 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263519AbUCTTxi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 14:53:38 -0500
Date: Sat, 20 Mar 2004 11:53:28 -0800
From: Greg KH <greg@kroah.com>
To: Johannes Resch <jr@xor.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.25: USB problems ("device not accepting new address")
Message-ID: <20040320195328.GA12197@kroah.com>
References: <11226.62.46.180.215.1079780733.squirrel@62.46.180.215>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11226.62.46.180.215.1079780733.squirrel@62.46.180.215>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2004 at 12:05:33PM +0100, Johannes Resch wrote:
> Hello,
> 
> I've got the problem that the USB mouse device will cease responding after
> some time. "dmesg" then shows:
> 
> usb-uhci.c: interrupt, status 2, frame# 699
> usb.c: USB device not accepting new address=2 (error=-110)
> hub.c: new USB device 00:1d.1-2, assigned address 3
> usb.c: USB device not accepting new address=3 (error=-110)

This is a PCI interrupt routing issue, not a USB issue.  I suggest
disabing acpi if you do not need it.  If you require acpi, then please
take this to the acpi mailing list, the people there will work with you
to solve it.

Good luck,

greg k-h
