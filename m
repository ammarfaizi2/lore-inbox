Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbTLPRrO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 12:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbTLPRrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 12:47:13 -0500
Received: from mail.kroah.org ([65.200.24.183]:26843 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262030AbTLPRrB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 12:47:01 -0500
Date: Tue, 16 Dec 2003 09:46:39 -0800
From: Greg KH <greg@kroah.com>
To: Carlos =?iso-8859-1?Q?Jim=E9nez?= <lordeath@linuxspain.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: UHCI-HCD && mosedev on 2.6.0-test11
Message-ID: <20031216174639.GD2716@kroah.com>
References: <1071536070.12406.5.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1071536070.12406.5.camel@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 16, 2003 at 01:55:34AM +0100, Carlos Jiménez wrote:
> Hello,
> 
> I have an usbmouse that works on 2.4.x kernel series.
> now on 2.6.0 usb module hangs, and does not work with it.

Did this happen when you removed the device?  Can you try the latest -bk
tree?  There have been a number of fixes that will hopefully fix this
problem for you.

thanks,

greg k-h
