Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266896AbUI1Auk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266896AbUI1Auk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 20:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267445AbUI1Auk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 20:50:40 -0400
Received: from mail.kroah.org ([69.55.234.183]:41705 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266896AbUI1Auj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 20:50:39 -0400
Date: Mon, 27 Sep 2004 17:48:42 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>, Lukas Hejtmanek <xhejtman@fi.muni.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm2 pcmcia oops
Message-ID: <20040928004842.GB10620@kroah.com>
References: <20040926221614.GB1466@mail.muni.cz> <20040926184327.79e05988.akpm@osdl.org> <20040927070023.A30364@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040927070023.A30364@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2004 at 07:00:23AM +0100, Russell King wrote:
> On Sun, Sep 26, 2004 at 06:43:27PM -0700, Andrew Morton wrote:
> > Well quirk_usb_early_handoff() should be __devinit, not __init.
> 
> I thought we got all those?  I guess the recent PCI quirk cleanup
> reintroduced these bugs.

No, these are new functions added in my trees.  I'll go apply Andrew's
patch, it is correct.

thanks,

greg k-h
