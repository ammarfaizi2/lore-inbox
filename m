Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264485AbUBPFwf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 00:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265350AbUBPFwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 00:52:35 -0500
Received: from mail.kroah.org ([65.200.24.183]:65189 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264485AbUBPFwd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 00:52:33 -0500
Date: Sun, 15 Feb 2004 19:58:35 -0800
From: Greg KH <greg@kroah.com>
To: Andy Lutomirski <luto@myrealbox.com>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [BUG] usblp_write spins forever after an error
Message-ID: <20040216035834.GA4089@kroah.com>
References: <402FEAD4.8020602@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <402FEAD4.8020602@myrealbox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 15, 2004 at 01:55:32PM -0800, Andy Lutomirski wrote:
> I recently cancelled a print job with the printer's cancel function, and 
> the CUPS backend got stuck in usblp_write (using 100% CPU and not 
> responding to signals).

What kernel are you referring to here?

thanks,

greg k-h
