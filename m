Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262048AbUBWVPJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 16:15:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262051AbUBWVNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 16:13:36 -0500
Received: from mail.kroah.org ([65.200.24.183]:52688 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262050AbUBWVJD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 16:09:03 -0500
Date: Mon, 23 Feb 2004 13:04:48 -0800
From: Greg KH <greg@kroah.com>
To: Pat Gefre <pfg@sgi.com>
Cc: davidm@napali.hpl.hp.com, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [2.6 PATCH] Altix hotplug
Message-ID: <20040223210448.GA22598@kroah.com>
References: <200402231455.i1NEtEqJ041950@fsgi900.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402231455.i1NEtEqJ041950@fsgi900.americas.sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 23, 2004 at 08:55:14AM -0600, Pat Gefre wrote:
> +#define SYSCTL_PCI_UNINITIALIZED	(SYSCTL_PCI_ERROR_BASE - 0)
> +    { SYSCTL_PCI_UNINITIALIZED, "module not initialized" },

What are you going to do with this large table of strings?  I see where
you copy them to somewhere, but don't see anything beyond that.

Are we missing a huge piece of the puzzle?

thanks,

greg k-h
