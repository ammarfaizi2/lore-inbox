Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751311AbVKLEsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbVKLEsN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 23:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbVKLEsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 23:48:13 -0500
Received: from mail.kroah.org ([69.55.234.183]:63925 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751311AbVKLEsM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 23:48:12 -0500
Date: Fri, 11 Nov 2005 20:33:20 -0800
From: Greg KH <gregkh@suse.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: SysFS 'module' params with CONFIG_MODULES=n
Message-ID: <20051112043320.GA27472@suse.de>
References: <20051111153220.GQ3839@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051111153220.GQ3839@smtp.west.cox.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2005 at 08:32:20AM -0700, Tom Rini wrote:
> On 2.6.14, and probably newer, a system where CONFIG_MODULES=n
> /sys/module/foo/parameters/param fails:
> 
> # cat /sys/module/tcp_bic/parameters/low_window
> cat: /sys/module/tcp_bic/parameters/low_window: Permission denied
> 
> But just changing MODULES to y:
> 
> # cat /sys/module/tcp_bic/parameters/low_window
> 14
> 
> Is this intentional or fixable?  Just an observation right now, thanks.

Not intentional at all.  Did this work before 2.6.14?

thanks,

greg k-h
