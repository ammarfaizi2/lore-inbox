Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932200AbVHHUEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbVHHUEo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 16:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbVHHUEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 16:04:44 -0400
Received: from mail.kroah.org ([69.55.234.183]:64911 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932200AbVHHUEo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 16:04:44 -0400
Date: Mon, 8 Aug 2005 13:02:52 -0700
From: Greg KH <greg@kroah.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: torvalds@osdl.org, ralf@linux-mips.org, linux-kernel@vger.kernel.org,
       linville@redhat.com
Subject: Re: pci_update_resource() getting called on sparc64
Message-ID: <20050808200251.GA2046@kroah.com>
References: <20050808160846.GA7710@kroah.com> <20050808.123209.59463259.davem@davemloft.net> <20050808194249.GA6729@kroah.com> <20050808.125432.74747546.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050808.125432.74747546.davem@davemloft.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2005 at 12:54:32PM -0700, David S. Miller wrote:
> From: Greg KH <greg@kroah.com>
> Date: Mon, 8 Aug 2005 12:42:49 -0700
> 
> > Linus, can you just revert that changeset for now?  That will sove
> > David's problem, and I'll work on getting this patch working properly
> > for after 2.6.13 is out.
> 
> Agreed.
> 
> I even have a patch I'll submit to you which will get sparc64
> converted over to using drivers/pci/setup-res.c so that none
> of this kind of non-sense will occur in the future.

That sounds even better.

thanks,

greg k-h
