Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262567AbTJGSBT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 14:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262569AbTJGSBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 14:01:18 -0400
Received: from mail.kroah.org ([65.200.24.183]:43756 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262567AbTJGSBQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 14:01:16 -0400
Date: Tue, 7 Oct 2003 11:01:06 -0700
From: Greg KH <greg@kroah.com>
To: merwan kashouty <kashouty@dakotainet.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test6 usblp and scanner lock system
Message-ID: <20031007180105.GF1956@kroah.com>
References: <3F81778E.6000807@dakotainet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F81778E.6000807@dakotainet.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 06, 2003 at 09:09:18AM -0500, merwan kashouty wrote:
> modprobing usblp and scanner on my system lock the console... i can 
> switch consoles and continue to work but the output of 
> /lib/modules/2.6.0-test6/modules.symbols looks like this....

Can you press Alt-SysRq-T and see where the kernel is stuck in the usb
drivers?

thanks,

greg k-h
