Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272050AbTHMXyy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 19:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272059AbTHMXyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 19:54:54 -0400
Received: from mail.kroah.org ([65.200.24.183]:21131 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S272050AbTHMXyw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 19:54:52 -0400
Date: Wed, 13 Aug 2003 16:42:21 -0700
From: Greg KH <greg@kroah.com>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test3-mm2: Badness in class_dev_release at drivers/base/class.c
Message-ID: <20030813234220.GB7863@kroah.com>
References: <1060803513.1221.2.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060803513.1221.2.camel@teapot.felipe-alfaro.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 13, 2003 at 09:38:34PM +0200, Felipe Alfaro Solana wrote:
> Hi!
> 
> I've seen the following oops when I was unplugging my HP Deskjet 970Cxi
> USB printer from its USB socket:
> 
> usb 1-1: USB disconnect, address 2
> Device class 'lp0' does not have a release() function, it is broken and
> must be fixed.
> Badness in class_dev_release at drivers/base/class.c:201

I have a fix for this in my tree, it will get sent to Linus in a few
days.

thanks for the report.

greg k-h
