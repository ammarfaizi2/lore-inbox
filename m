Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261760AbTIYSvm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 14:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261853AbTIYSvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 14:51:42 -0400
Received: from mail.kroah.org ([65.200.24.183]:4826 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261760AbTIYSvi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 14:51:38 -0400
Date: Thu, 25 Sep 2003 11:50:39 -0700
From: Greg KH <greg@kroah.com>
To: Philippe Troin <phil@fifi.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops in vanilla 2.4.22 serial-usb driver
Message-ID: <20030925185039.GB29088@kroah.com>
References: <87llsdy01v.fsf@ceramic.fifi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87llsdy01v.fsf@ceramic.fifi.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 24, 2003 at 09:17:00PM -0700, Philippe Troin wrote:
> This happened at the end of a Palm sync.
> The machine went on, but USB is not irresponsive to USB attach/detach
> since khubd is dead. The USB low-level driver is UHCI_ALT, compiled
> in-kernel.

This should be fixed in the 2.4.23-pre tree now.  If you want, you can
try applying the patch at:
	http://www.kernel.org/pub/linux/kernel/people/gregkh/usb/2.4/usb-serial-02-2.4.23-pre3.patch
if you don't want the whole -pre tree.

> BTW, is there any way to restart khubd without rebooting?

Nope, sorry.

Let me know if this doesn't solve the problem for you.

thanks,

greg k-h
