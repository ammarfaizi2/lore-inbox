Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270324AbTHGQX2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 12:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270375AbTHGQX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 12:23:27 -0400
Received: from mail.kroah.org ([65.200.24.183]:16783 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270324AbTHGQXZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 12:23:25 -0400
Date: Thu, 7 Aug 2003 09:23:41 -0700
From: Greg KH <greg@kroah.com>
To: frahm@irsamc.ups-tlse.fr
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2: lost mouse  synchronization after apm-suspend
Message-ID: <20030807162341.GA11418@kroah.com>
References: <200308071433.h77EXIxU001088@albireo.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308071433.h77EXIxU001088@albireo.free.fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 07, 2003 at 04:33:18PM +0200, frahm@irsamc.ups-tlse.fr wrote:
> 
> I have been testing the kernel version 2.6.0-test2 on a Dell Latitude C840. 
> After an apm-suspend the psmouse is becoming crazy, i.e. the mouse 
> lost synchronization and dmesg provides:

Unload all usb drivers before suspending please.

thanks,

greg k-h
