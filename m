Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263396AbTECTSF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 15:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263391AbTECTSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 15:18:05 -0400
Received: from granite.he.net ([216.218.226.66]:36112 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S263396AbTECTRO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 15:17:14 -0400
Date: Sat, 3 May 2003 12:31:35 -0700
From: Greg KH <greg@kroah.com>
To: Andrei Ivanov <andrei.ivanov@ines.ro>
Cc: linux-kernel@vger.kernel.org
Subject: Re: usb [mouse] not working in mm4
Message-ID: <20030503193135.GA17970@kroah.com>
References: <Pine.LNX.4.50L0.0305031550330.4098-200000@webdev.ines.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50L0.0305031550330.4098-200000@webdev.ines.ro>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 03, 2003 at 03:55:12PM +0300, Andrei Ivanov wrote:
> usb 1-2: USB device not accepting new address=2 (error=-110)
> hub 1-0:0: new USB device on port 2, assigned address 3
> usb 1-2: USB device not accepting new address=3 (error=-110)

Hm, interrupts aren't getting to the usb host controller.  Does this
work ok on the latest -bk tree for you?

thanks,

greg k-h
