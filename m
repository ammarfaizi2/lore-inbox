Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261359AbUKCDEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbUKCDEM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 22:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbUKCDEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 22:04:12 -0500
Received: from mail.kroah.org ([69.55.234.183]:63618 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261359AbUKCDEI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 22:04:08 -0500
Date: Tue, 2 Nov 2004 18:28:24 -0800
From: Greg KH <greg@kroah.com>
To: "Kilau, Scott" <Scott_Kilau@digi.com>
Cc: germano.barreiro@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: patch for sysfs in the cyclades driver
Message-ID: <20041103022824.GA10941@kroah.com>
References: <71A17D6448EC0140B44BCEB8CD0DA36E04B9D812@minimail.digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71A17D6448EC0140B44BCEB8CD0DA36E04B9D812@minimail.digi.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2004 at 02:51:33PM -0600, Kilau, Scott wrote:
> I know you have done work on USB serial drivers with devices with
> multiple ports...
> Is there any way to create a file in sys that can point back to a port,
> and NOT the port's
> parent (ie, the board) WITHOUT having to create a new kobject per port?

What's wrong with the kobject in /sys/class/tty/ which has one object
per port?  I think we might not be exporting that class_device
structure, but I would not have a problem with doing that.

thanks,

greg k-h
