Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263150AbVGOCUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263150AbVGOCUJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 22:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263163AbVGOCSf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 22:18:35 -0400
Received: from mail.kroah.org ([69.55.234.183]:29671 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263183AbVGOCQK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 22:16:10 -0400
Date: Thu, 14 Jul 2005 19:15:59 -0700
From: Greg KH <greg@kroah.com>
To: Adam Belay <abelay@novell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] PCI bus class driver rewrite for 2.6.13-rc2 [0/9]
Message-ID: <20050715021558.GA7740@kroah.com>
References: <1121331296.3398.88.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121331296.3398.88.camel@localhost.localdomain>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2005 at 04:54:56AM -0400, Adam Belay wrote:
> Hi all,
> 
> I'm in the process of overhauling some aspects of the PCI subsystem.
> This patch series is a rewrite of the PCI probing and detection code.
> It creates a well defined PCI bus class API and allows a standard PCI
> driver to bind to PCI bridge devices.  This results in the following:
> 
> * cleaner code
> * improved driver core support
> * the option of adding new PCI bridge drivers
> * better power management

This looks great, thanks for doing this.

> For these changes to be fully effective, the following code (some of
> which was broken by these changes) will need to be fixed:

<snip>

Good luck with all of this, it's a lot :)

thanks,

greg k-h
