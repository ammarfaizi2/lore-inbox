Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030614AbWBODUU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030614AbWBODUU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 22:20:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030613AbWBODUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 22:20:20 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:23506
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1030614AbWBODUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 22:20:18 -0500
Date: Tue, 14 Feb 2006 19:19:59 -0800
From: Greg KH <gregkh@suse.de>
To: Hansjoerg Lipp <hjlipp@web.de>
Cc: Karsten Keil <kkeil@suse.de>, i4ldeveloper@listserv.isdn4linux.de,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Tilman Schmidt <tilman@imap.cc>
Subject: Re: [PATCH 1/9] isdn4linux: Siemens Gigaset drivers - Kconfigs and Makefiles
Message-ID: <20060215031959.GA5099@suse.de>
References: <gigaset307x.2006.02.11.001.0@hjlipp.my-fqdn.de> <gigaset307x.2006.02.11.001.1@hjlipp.my-fqdn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gigaset307x.2006.02.11.001.1@hjlipp.my-fqdn.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 11, 2006 at 03:52:27PM +0100, Hansjoerg Lipp wrote:
> From: Tilman Schmidt <tilman@imap.cc>, Hansjoerg Lipp <hjlipp@web.de>
> 
> This patch prepares the kernel build infrastructure for addition of the
> Gigaset ISDN drivers. It creates a Makefile and Kconfig file for the
> Gigaset driver and hooks them into those of the isdn4linux subsystem.
> It also adds a MAINTAINERS entry for the driver.
> 
> This patch depends on patches 2 to 9 of the present set, as without the
> actual source files, activating the options added here will cause the
> kernel build to fail.

Care to redo that and add the Makefile change at the same time as the
driver goes into the tree?  We don't want to break the buid for a
specific patch.

thanks,

greg k-h
