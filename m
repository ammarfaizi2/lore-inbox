Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265615AbUAZXhX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 18:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265619AbUAZXhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 18:37:23 -0500
Received: from mail.kroah.org ([65.200.24.183]:18640 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265615AbUAZXhU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 18:37:20 -0500
Date: Mon, 26 Jan 2004 15:37:13 -0800
From: Greg KH <greg@kroah.com>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: gkrellm reports cpu temp*10! linux-athlon kernel=2.6.2-rc1-mm2
Message-ID: <20040126233713.GA7535@kroah.com>
References: <200401261612.17942.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401261612.17942.gene.heskett@verizon.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 26, 2004 at 04:12:17PM -0500, Gene Heskett wrote:
> Hi all;
> 
> I just rebooted 2 days ago to 2.6.2-rc1-mm2, and I just now noticed 
> that gkrellm is reporting my cpu at 680C.  Thats about 10x what its 
> running at, still warm at 68C, but functional for 2 years now.  I 
> didn't have this error under 2.6.1-rc2-mm4.
>  
> Any idea what patch to back out?  And where to get it?

It's part of the recent i2c changes.  Ask on the sensor's list for what
needs to be changed in gkrellm to fix this.

thanks,

greg k-h
