Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262251AbTKRADO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 19:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262274AbTKRADN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 19:03:13 -0500
Received: from mail.kroah.org ([65.200.24.183]:22701 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262251AbTKRADL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 19:03:11 -0500
Date: Mon, 17 Nov 2003 16:02:14 -0800
From: Greg KH <greg@kroah.com>
To: John Heil <kerndev@sc-software.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org,
       John Heil <johnhscs@scsoftware.sc-software.com>
Subject: Re: [PATCH] [USB2] 2.6.0-test9-mm2 HiSpd Isoc 1024KB submits: -EMSGSIZE
Message-ID: <20031118000214.GA11709@kroah.com>
References: <Pine.LNX.4.33.0311171529030.5878-100000@scsoftware.sc-software.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0311171529030.5878-100000@scsoftware.sc-software.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 17, 2003 at 03:53:19PM -0800, John Heil wrote:
> 
> High speed isochronous URB submits fail w -EMSGSIZE when packet
> size is 1024KB (which is permitted by the USB 2.0 Std).

Nice, what kind of usb 2.0 iso device do you have that needs this?  The
linux usb developers would really like some of these so they could test
:)

Anyway, try sending this patch to the EHCI maintainer, and the
linux-usb-devel mailing list, they can better address this patch.

thanks,

greg k-h
