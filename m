Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbTEETEv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 15:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261235AbTEETEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 15:04:51 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:61951 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261234AbTEETEu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 15:04:50 -0400
Date: Mon, 5 May 2003 12:18:16 -0700
From: Greg KH <greg@kroah.com>
To: ebuddington@wesleyan.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.68: BUG at usb-storage:963 on 'rmmod uhci-hcd'
Message-ID: <20030505191816.GA2277@kroah.com>
References: <20030504015421.A267@ma-northadams1b-60.bur.adelphia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030504015421.A267@ma-northadams1b-60.bur.adelphia.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 04, 2003 at 01:54:21AM -0400, Eric Buddington wrote:
> 
> Upon trying to rmmod the uhci-hcd module, I get the BUG shown in the
> dmesg output below.

removing usb host controllers is known to not work properly right now
since about 2.5.67, sorry.  People are slowly looking at it, and help is
always appreciated :)

thanks,

greg k-h
