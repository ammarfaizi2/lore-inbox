Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263821AbTLOSRq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 13:17:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263830AbTLOSRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 13:17:45 -0500
Received: from mail.kroah.org ([65.200.24.183]:17079 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263821AbTLOSRb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 13:17:31 -0500
Date: Mon, 15 Dec 2003 10:16:53 -0800
From: Greg KH <greg@kroah.com>
To: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PCI Express support for 2.4 kernel
Message-ID: <20031215181653.GA7128@kroah.com>
References: <Pine.LNX.4.44.0312150917170.32061-100000@coffee.psychology.mcmaster.ca> <3FDDD8C6.3080804@intel.com> <3FDDDC68.80209@backtobasicsmgmt.com> <3FDDE39E.1050300@intel.com> <Pine.LNX.4.53.0312151150090.10342@chaos> <3FDDEE32.7050900@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FDDEE32.7050900@intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 15, 2003 at 07:24:02PM +0200, Vladimir Kondratiev wrote:
> 
> Finally, let's stop this thread. Let it be up to person who will be (if 
> it will happen) checking this code into kernel, to decide on coding 
> style.

For 2.6, that person would be me. 

> I, personally, value code clarity more then 4 bytes in executable
> size. But I will not object if more experienced kernel maintainers
> have another priority.

Please remove the initialized variable to conserve size (if you really
want to, a comment like /* initialized to NULL */ is ok to have to
remind you that this is how it works.)

greg k-h
