Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161119AbVKDDD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161119AbVKDDD5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 22:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161120AbVKDDD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 22:03:56 -0500
Received: from mail.kroah.org ([69.55.234.183]:39847 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161119AbVKDDD4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 22:03:56 -0500
Date: Thu, 3 Nov 2005 18:57:41 -0800
From: Greg KH <greg@kroah.com>
To: David Liontooth <liontooth@cogweb.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14 qc-usb oops on amd64 smp
Message-ID: <20051104025741.GA2793@kroah.com>
References: <42ABBE6F.8080406@brturbo.com.br> <42ABC3C4.4050406@brturbo.com.br> <20050614170137.690e0328.akpm@osdl.org> <42AFF53A.5060107@cogweb.net> <436A5AB9.4080102@cogweb.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <436A5AB9.4080102@cogweb.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2005 at 10:45:13AM -0800, David Liontooth wrote:
> 
>  * amd64 dual opteron
>  * vanilla linux 2.6.14
>  * qc-usb-source 0.6.3-1
>  * gcc 4.0
>  * Debian sid
> 
> The driver did not work with motv, rmmod -f quickcam failed, and
> unplugging the quickcam then caused the following oops.
> 
> The kernel is nvidia tainted; if relevant, I'll be happy to test without
> the nvidia module. The quickcam worked in 2.6.12.

Why not ask the quickcam driver authors, there's not much we can do here
about this.

Good luck,

greg k-h
