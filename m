Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750981AbWFAXng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbWFAXng (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 19:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750991AbWFAXng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 19:43:36 -0400
Received: from xenotime.net ([66.160.160.81]:33460 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750981AbWFAXng (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 19:43:36 -0400
Date: Thu, 1 Jun 2006 16:46:17 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB devices fail unnecessarily on unpowered hubs
Message-Id: <20060601164617.b75b484d.rdunlap@xenotime.net>
In-Reply-To: <447F79BA.4090904@shaw.ca>
References: <6iWP5-2gj-71@gated-at.bofh.it>
	<6iX82-2UJ-3@gated-at.bofh.it>
	<447F79BA.4090904@shaw.ca>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Jun 2006 17:35:22 -0600 Robert Hancock wrote:

> linux-os (Dick Johnson) wrote:
> > Many, most, perhaps all such devices don't take more power when they
> > are "enabled". Everything is already running and sucking up maximum
> > current when you plug it in! If the motherboard didn't smoke when
> > the device was plugged in, you might just as well let the user use
> > it! Perhaps a ** WARNING ** message somewhere, but by golly, they
> > got it running or else you wouldn't be able to read its parameters.
> 
> Wrong.. USB devices are not allowed to draw more than some amount (100 
> mA I think) of power before the host tells it that it is allowed to 
> switch into full-power mode. Any device that doesn't do this doesn't 
> comply with the USB specs. Therefore it is very possible to connect a 
> device and discover that it can't be enabled.

so does Thunderbird on Windows have absolutely no Reply-to-All
and no References or In-Reply-To capabilities?

---
~Randy
