Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264169AbTKSXsN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 18:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264172AbTKSXsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 18:48:13 -0500
Received: from mail.kroah.org ([65.200.24.183]:59566 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264169AbTKSXsM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 18:48:12 -0500
Date: Wed, 19 Nov 2003 15:47:08 -0800
From: Greg KH <greg@kroah.com>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: christophe.varoqui@free.fr, patmans@us.ibm.com
Subject: Re: [ANNOUNCE] udev 006 release
Message-ID: <20031119234708.GC23529@kroah.com>
References: <20031119162912.GA20835@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031119162912.GA20835@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 19, 2003 at 08:29:12AM -0800, Greg KH wrote:
> The major changes since the 005 release are:

Oops, two more major changes I forgot to mention:
	- udev.permissions can now handle wild cards.  So the following
	  line would apply for all ttyUSB devices:
	  	ttyUSB*:::0666
	- I've added two external programs to the udev tarball, under
	  the extras/ directory.  They are the scsi-id program from Pat
	  Mansfield, and the multipath program from Christophe Varoqui.
	  Both of them can work as CALLOUT programs.  I don't think they
	  currently build properly within the tree, by linking against
	  klibc, but patches to their Makefiles to fix this would be
	  gladly accepted :)

Thanks a lot to both Pat and Christophe for letting me include their
programs in the main udev release, I appreciate it.  And if there's any
other small programs that people want me to bundle within udev, please
let me know.

thanks,

greg k-h
