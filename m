Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbTLUAxu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 19:53:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261909AbTLUAxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 19:53:50 -0500
Received: from mail.kroah.org ([65.200.24.183]:39575 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261898AbTLUAxt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 19:53:49 -0500
Date: Sat, 20 Dec 2003 16:49:09 -0800
From: Greg KH <greg@kroah.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@osdl.org>, Matthias Andree <matthias.andree@gmx.de>,
       Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Fw: 2.6.0-test11 BK: sg and scanner modules not auto-loaded?
Message-ID: <20031221004909.GA2356@kroah.com>
References: <20031219181039.GI3017@kroah.com> <20031221003020.63E6A2C0B8@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031221003020.63E6A2C0B8@lists.samba.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 20, 2003 at 02:04:59PM +1100, Rusty Russell wrote:
> 
> It's been argued that kmod should place a request with the hotplug
> subsystem, rather than call modprobe, but that's a little too radical
> for me just yet.

That's not too radical, just requires a small script addition in
userspace that actually runs modprobe based on a specific hotplug event.
In all we'd probably only reduce the kernel by the size of the modprobe
array, and the sysctl table, which isn't all that much.

Put it on the 2.7 list :)

thanks,

greg k-h
