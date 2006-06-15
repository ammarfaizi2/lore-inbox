Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751266AbWFOH3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbWFOH3M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 03:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbWFOH3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 03:29:11 -0400
Received: from mail.kroah.org ([69.55.234.183]:48810 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751266AbWFOH3K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 03:29:10 -0400
Date: Thu, 15 Jun 2006 00:28:54 -0700
From: Greg KH <greg@kroah.com>
To: Sergej Pupykin <ps@lx-ltd.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: resubmitting intr urb in 2.4 and 2.6 kernels
Message-ID: <20060615072854.GA29713@kroah.com>
References: <m3lkrzq3zj.fsf@lx-ltd.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3lkrzq3zj.fsf@lx-ltd.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2006 at 05:08:32PM +0400, Sergej Pupykin wrote:
> 
> Hi!
> 
> Could anybody explain the reason why intr urb auto resubmitting was removed
> from 2.6 kernels?
> 
> Or just tell me, it was removed because of some technical problems in it
> or only for better architecure?
> 
> If it was architecure cleanup, why autoresubmitting was implemented in 2.4?

Consistancy, now all urbs work the same way, and you don't have to
remember special things depending on the type of the endpoint.  Search
the archives of the linux-usb-devel mailing list early in the 2.5
development series for the details if you are curious.


thanks,

greg k-h
