Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262462AbUJ0PmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262462AbUJ0PmI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 11:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262458AbUJ0PmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 11:42:07 -0400
Received: from mail.kroah.org ([69.55.234.183]:20618 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262492AbUJ0Phy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 11:37:54 -0400
Date: Wed, 27 Oct 2004 08:37:16 -0700
From: Greg KH <greg@kroah.com>
To: Norbert Preining <preining@logic.at>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.10-mm1, class_simple_* and GPL addition
Message-ID: <20041027153715.GB13991@kroah.com>
References: <20041027135052.GE32199@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041027135052.GE32199@gamma.logic.tuwien.ac.at>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2004 at 03:50:52PM +0200, Norbert Preining wrote:
> Hi Andrew!
> 
> The change from 
> 	EXPORT_SYMBOL
> to
> 	EXPORT_SYMBOL_GPL
> for class_simple_* makes the nvidia module useless as it uses several:
> nvidia: Unknown symbol class_simple_device_add
> nvidia: Unknown symbol class_simple_destroy
> nvidia: Unknown symbol class_simple_device_remove
> nvidia: Unknown symbol class_simple_create

I think these changes are only in the Gentoo modified version of the
driver, right?  I don't think that nvidia wrote the driver that way.

> I don't want to start a flame war and long discussion, just want to ask
> wether this change (to _GPL) was intended,

Yes it was.

> and if yes, if there is a way to fix nvidia kernel modules (or others)
> using this device management interface.

Get them to change the license on their code.

Good luck,

thanks,

greg k-h
