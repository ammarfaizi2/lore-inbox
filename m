Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263833AbTIIArO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 20:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263853AbTIIArO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 20:47:14 -0400
Received: from mail.kroah.org ([65.200.24.183]:27107 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263833AbTIIArM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 20:47:12 -0400
Date: Mon, 8 Sep 2003 17:46:07 -0700
From: Greg KH <greg@kroah.com>
To: Dale Harris <rodmur@maybe.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: USBNET in Linux 2.6.0-test5
Message-ID: <20030909004607.GA3747@kroah.com>
References: <20030908233407.GT16695@maybe.org> <20030908235101.GA3477@kroah.com> <20030909002938.GU16695@maybe.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030909002938.GU16695@maybe.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 08, 2003 at 05:29:38PM -0700, Dale Harris wrote:
> CONFIG_USB_USBNET=m

Hm, you selected CONFIG_USB_USBNET and then didn't select any actual
devices that the usbnet driver should support?  That's not a good idea,
and the error message you got is correct.  Please choose at least one
device to support, or do not select the option at all.

thanks,

greg k-h
