Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262193AbVBJSeD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262193AbVBJSeD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 13:34:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262194AbVBJSeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 13:34:03 -0500
Received: from mail.kroah.org ([69.55.234.183]:11447 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262193AbVBJSdt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 13:33:49 -0500
Date: Thu, 10 Feb 2005 10:33:38 -0800
From: Greg KH <greg@kroah.com>
To: Adam Belay <abelay@novell.com>
Cc: rml@novell.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] add driver matching priorities
Message-ID: <20050210183338.GA9308@kroah.com>
References: <1106951404.29709.20.camel@localhost.localdomain> <20050210084113.GZ32727@kroah.com> <1108055918.3423.23.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1108055918.3423.23.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2005 at 12:18:37PM -0500, Adam Belay wrote:
> 
> The second "*match" function in "struct device_driver" gives the driver
> a chance to evaluate it's ability of controlling the device and solves a
> few problems with the current implementation.  (ex. it's not possible to
> detect ISA Modems with only a list of PnP IDs, and some PCI devices
> support a pool of IDs that is too large to put in an ID table).

What deficiancy in the current id tables do you see?  What driver has a
id table that is "too big"?  Is there some way we can change it to make
it work better?

thanks,

greg k-h
