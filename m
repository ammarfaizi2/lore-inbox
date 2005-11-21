Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751093AbVKUWJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbVKUWJU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 17:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbVKUWJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 17:09:20 -0500
Received: from mail.kroah.org ([69.55.234.183]:49033 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751093AbVKUWJT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 17:09:19 -0500
Date: Mon, 21 Nov 2005 13:47:33 -0800
From: Greg KH <gregkh@suse.de>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Secure Digital Host Controller PCI class
Message-ID: <20051121214733.GA17793@suse.de>
References: <4381B364.2020808@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4381B364.2020808@drzeus.cx>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2005 at 12:45:40PM +0100, Pierre Ossman wrote:
> I'm working on a driver for the Secure Digital Host Controller
> interface. This is a generic interface, so it uses a PCI class for
> identification instead of vendor/device ids.
> 
> The class ID used is 0805 and the programming interface (correct term?)
> indicates DMA capabilities. Greg, since you're the PCI maintainer,
> perhaps you have the possibility of checking this ID?

What do you mean "checking this ID"?  Checking it with what?

> The standard also dictates a register at offset 0x40 in PCI space. This
> is a one byte register detailing the number of slots on the controller
> and the first BAR to use.

Do you have a pointer to the standard?

thanks,

greg k-h
