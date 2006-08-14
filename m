Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932614AbWHNVNy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932614AbWHNVNy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 17:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932709AbWHNVNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 17:13:54 -0400
Received: from mail.kroah.org ([69.55.234.183]:64231 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932614AbWHNVNv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 17:13:51 -0400
Date: Mon, 14 Aug 2006 14:03:08 -0700
From: Greg KH <greg@kroah.com>
To: Mike Galbraith <efault@gmx.de>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: 2.6.18-rc3-mm2:  oops in device_bind_driver()
Message-ID: <20060814210308.GH11673@kroah.com>
References: <1155385726.6151.6.camel@Homer.simpson.net> <20060812180256.445caea9.akpm@osdl.org> <1155448234.7068.1.camel@Homer.simpson.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155448234.7068.1.camel@Homer.simpson.net>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 13, 2006 at 05:50:34AM +0000, Mike Galbraith wrote:
> On Sat, 2006-08-12 at 18:02 -0700, Andrew Morton wrote:
> 
> > I'd assume that you have CONFIG_PCI_MULTITHREAD_PROBE set, and
> 
> Yes.

Mauro, this is odd.  Anything in the dvb layer that would not like
multiple devices being probed at the same time?

thanks,

greg k-h
