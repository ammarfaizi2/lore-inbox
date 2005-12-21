Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964790AbVLUVe2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964790AbVLUVe2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 16:34:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750996AbVLUVe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 16:34:28 -0500
Received: from mail.kroah.org ([69.55.234.183]:4547 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750745AbVLUVe1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 16:34:27 -0500
Date: Wed, 21 Dec 2005 13:33:42 -0800
From: Greg KH <greg@kroah.com>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: vojtech@ucw.cz, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-rc5 and later: USB mouse IRQ post kills the computer post resume.
Message-ID: <20051221213342.GA8315@kroah.com>
References: <1135199640.9616.21.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1135199640.9616.21.camel@localhost>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2005 at 07:14:01AM +1000, Nigel Cunningham wrote:
> Hi Vojtech.
> 
> I have a HT box with USB mouse support built as modules. Beginning with
> 2.6.15-rc5 (maybe slightly earlier) a suspend/resume cycle makes the USB
> mouse get in an invalid state, such that I get a gazillion messages in
> the logs saying "unexpected IRQ trap at vector 99", or in some
> alternately a hard hang. No work around found yet. Are you the right man
> to talk to, or is Greg? (Spose I should cc him, so I'll add that now). I
> can use kdb if it's helpful. Would you like my kconfig?

This should be taken to the linux-usb-devel list, that's the best place
for it.

thanks,

greg k-h
