Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266813AbTGKWNa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 18:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266899AbTGKWNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 18:13:30 -0400
Received: from mail.kroah.org ([65.200.24.183]:8686 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266813AbTGKWN2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 18:13:28 -0400
Date: Fri, 11 Jul 2003 15:27:13 -0700
From: Greg KH <greg@kroah.com>
To: Ronald Jerome <imun1ty@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: generate-modprobe question and USB fatal error during INIT:-resending
Message-ID: <20030711222712.GC23189@kroah.com>
References: <20030711182015.71489.qmail@web13301.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030711182015.71489.qmail@web13301.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 11, 2003 at 11:20:15AM -0700, Ronald Jerome wrote:
> I see that the the sections for "usb-uhci" "mousedev"
> and "keybdev".   Those are incorrect.  They should be
> "uhci-hcd", "usbmouse" and "usbkbd".  Once I changed
> the "usb-uhci" to "uhci-hcd"  at least the usb
> installed ok but those changes I made for the mouse
> and keyboard still does not work.

Bleah, we are calling those drivers by their wrong names internally.
The code needs to be fixed, care to send me a patch?

thanks,

greg k-h
