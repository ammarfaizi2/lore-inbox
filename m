Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161181AbWJKTo6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161181AbWJKTo6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 15:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161185AbWJKTo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 15:44:58 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:15364 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1161181AbWJKTo5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 15:44:57 -0400
Date: Wed, 11 Oct 2006 19:44:43 +0000
From: Pavel Machek <pavel@suse.cz>
To: Paolo Abeni <paolo.abeni@email.it>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH] usbmon: add binary interface
Message-ID: <20061011194443.GA3935@ucw.cz>
References: <1160557065.9547.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1160557065.9547.12.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> From: Paolo Abeni <paolo.abeni@email.it>
> 
> A binary interface is added to usbmon. For each USB bus present on the host system a new file is added to the debugfs directory, in the form "usb%db".
> 
> USB records are stored in a liked list, alike current text interface implementation, so most code is shared from binary and text interface.
> This code has been moved into mon_commom.c.
> 
> The binary interface support resizing the amount of USB data stored in each record via an ioctl method.

Does it mean text interface is now deprecated? Or perhaps ioctl should
be added to text interface too? Or maybe we do not need binary
interface if we allow resizing on text interface?

							Pavel
-- 
Thanks for all the (sleeping) penguins.
