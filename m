Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932249AbWAJQxw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbWAJQxw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 11:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbWAJQxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 11:53:51 -0500
Received: from c-24-22-115-24.hsd1.or.comcast.net ([24.22.115.24]:28629 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S932249AbWAJQxv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 11:53:51 -0500
Date: Tue, 10 Jan 2006 08:53:47 -0800
From: Greg KH <gregkh@suse.de>
To: Grant Coady <gcoady@gmail.com>
Cc: Jesper Juhl <jesper.juhl@gmail.com>,
       LKML List <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.6.15-mm2 allyesconfig build failure in drivers/usb/ip/
Message-ID: <20060110165347.GA21240@suse.de>
References: <9a8748490601100546s2dcf9a25hcfd369e397bd7938@mail.gmail.com> <aoj7s1pmcvup9h47bnglk267s64vpm53a3@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoj7s1pmcvup9h47bnglk267s64vpm53a3@4ax.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2006 at 02:15:20AM +1100, Grant Coady wrote:
> On Tue, 10 Jan 2006 14:46:08 +0100, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> 
> >allyesconfig currently doesn't build completely for me in 2.6.15-mm2
> 
> I sent a patch http://lkml.org/lkml/2006/1/7/272

And I seem to have lost that one, care to bounce it to me?

Hm, no, wait, that patch is wrong, you want to be able to build both
drivers, and even into the kernel too.  The code is wrong, I'll work on
fixing it...

thanks,

greg k-h
