Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262396AbUKVVaX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262396AbUKVVaX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 16:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262342AbUKVTFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 14:05:54 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:51417 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262317AbUKVTEm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 14:04:42 -0500
Date: Mon, 22 Nov 2004 10:40:51 -0800
From: Greg KH <greg@kroah.com>
To: "Gerold J. Wucherpfennig" <gjwucherpfennig@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel thoughts of a Linux user
Message-ID: <20041122184051.GA6060@kroah.com>
References: <200411201131.12987.gjwucherpfennig@gmx.net> <20041121182952.GA26874@kroah.com> <200411222233.45709.gjwucherpfennig@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411222233.45709.gjwucherpfennig@gmx.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2004 at 10:33:45PM +0100, Gerold J. Wucherpfennig wrote:
> 
> I'm a stupid idiot, but I'm sure that the sysfs and hal thing still has to
> mature for a few years.

"mature for a few years" before what happens?  It becomes a fine
vintage, and everyone enjoys it?  Or it becomes a stinking pile of
decaying matter?  I don't understand what you are getting at here.

> Just imagine such things like listing all available modem devices.
> Listing /sys/class/tty/*/dev without the virtual consoles just isn't
> enough.

You can not determine "modem devices" by just listing tty devices.  tty
devices are tty devices, some of them can be acting like a modem (like a
ACM device) and others can just be a serial port connected to a modem.

If you have issues with how HAL works, talk to the developers of it.
It's a relativly new project, and they can use the help.  But please
realize that sysfs doesn't exist for the sole reason of HAL.  HAL was
created because sysfs enabled it to be created.

thanks,

greg k-h
