Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265226AbTIIXWb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 19:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265237AbTIIXWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 19:22:31 -0400
Received: from mail.kroah.org ([65.200.24.183]:39398 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265226AbTIIXW3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 19:22:29 -0400
Date: Tue, 9 Sep 2003 16:19:49 -0700
From: Greg KH <greg@kroah.com>
To: Remo Inverardi <invi@your.toilet.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OHCI Host Controler Died
Message-ID: <20030909231949.GA8175@kroah.com>
References: <3F5E4D93.9030804@your.toilet.ch> <20030909225125.GA7995@kroah.com> <3F5E5F61.6030406@your.toilet.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F5E5F61.6030406@your.toilet.ch>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 01:16:49AM +0200, Remo Inverardi wrote:
> Greg,
> 
> >Great, go bug vmware then :)
> 
> I will -- but ...
> 
> I was under the impression that all of VMware's USB code is running in 
> user space. Running "grep -ir usb ." in VMware's modules/source 
> directory did not return any hits, so this assumption is probably correct.

I'm under that impression too, but due to them requiring kernel drivers
to support their program, I can not be sure.

> This does look like a kernel bug to me, since it should not be possible 
> to crash the OHCI driver from user space.

I agree.  And if you can figure out how it does that, we would really
appreciate it :)

thanks,

greg k-h
