Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262337AbUKWIuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262337AbUKWIuV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 03:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262340AbUKWIuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 03:50:20 -0500
Received: from mail.kroah.org ([69.55.234.183]:24989 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262337AbUKWIsi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 03:48:38 -0500
Date: Tue, 23 Nov 2004 00:22:28 -0800
From: Greg KH <greg@kroah.com>
To: Dimitris Lampridis <labis@mhl.tuc.gr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI resource allocation problem in 2.6.8
Message-ID: <20041123082227.GE23974@kroah.com>
References: <1101049047.3201.18.camel@naousa.mhl.tuc.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101049047.3201.18.camel@naousa.mhl.tuc.gr>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 21, 2004 at 02:57:27PM +0000, Dimitris Lampridis wrote:
> Hi,
> I'm writing a driver for a PCI-based USB controller.

Something other than ohci, ehci, or uhci?  What kind?

> Any ideas? Is this something typical???

We fixed a bug in this area for the 2.6.9 release.  Can you try that
kernel and let us know if it fixes your problem too?

thanks,

greg k-h
